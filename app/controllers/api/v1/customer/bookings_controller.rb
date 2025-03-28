# frozen_string_literal: true

class Api::V1::Customer::BookingsController < ApplicationController
  before_action :authenticate_customer_user!, except: %i[ event_list ]
  before_action :set_event, only: %i[ create ]

  def index
    @bookings = current_user.bookings
                            .page(params[:page])
                            .per(params[:per_page])

    response_success("Booking list",
                      200,
                      array_serializer_for(resource: @bookings, serializer: BookingSerializer),
                      @bookings.total_pages,
                      @bookings.total_count
                    )
  end

  def event_list
    @events = Event.filter_condition(params)
                  .page(params[:page])
                  .per(params[:per_page])

    response_success("Event list",
                      200,
                      array_serializer_for(resource: @events, serializer: EventSerializer),
                      @events.total_pages,
                      @events.total_count
                    )
  end

  def create
    @booking = @event.bookings.create(booking_params)
    return response_failure("", 422, @booking.errors.full_messages[0]) if @booking.errors.any?

    job_id = BookingConfirmationJob.perform_at(Time.zone.now, @booking.id)
    @booking.update(job_id: job_id)

    response_success("Event booked successfully",
                      200,
                      serializer_for(resource: @booking, serializer: BookingSerializer))
  end

  def cancel_booking
    @booking = Booking.find_by(id: params[:id])
    return response_failure("", 404, "Booking not found") unless @booking
    return response_failure("", 422, @booking.errors.full_messages[0]) unless @booking.destroy

    response_success("Booking cancelled successfully",
                      200,
                      nil)
  end

  private

  def booking_params
    params.require(:booking).permit(:quantity, :ticket_id, :event_id)
                            .merge(user_id: current_user.id, booked_date_time: Time.now, reference_number: SecureRandom.hex(10))
  end

  def set_event
    @event = Event.find_by(id: params[:event_id])
    return response_failure("", 404, "Event not found") unless @event
  end
end
