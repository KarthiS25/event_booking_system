# frozen_string_literal: true

class Api::V1::EventOrganizer::EventsController < ApplicationController
  before_action :authenticate_organize_user!
  before_action :set_event, only: %i[show update destroy]

  def index
    @events = current_user.events
                          .filter_condition(params)
                          .page(params[:page])
                          .per(params[:per_page])

    response_success("Event list",
                      200,
                      array_serializer_for(resource: @events, serializer: EventSerializer),
                      @events.total_pages,
                      @events.total_count
                    )
  end

  def show
    response_success("Event details", 200, serializer_for(resource: @event, serializer: EventSerializer))
  end

  def create
    @event = Event.create(event_params)
    return error_message if @event.errors.any?

    response_success("Event created successfully", 200, serializer_for(resource: @event, serializer: EventSerializer))
  end

  def update
    return error_message unless @event.update(event_params)

    remove_existing_job(@event.job_id) if @event.job_id.present?
    job_id = NotificationJob.perform_at(Time.zone.now, @event.id)
    @event.update(job_id: job_id)

    response_success("Event updated successfully", 200, serializer_for(resource: @event, serializer: EventSerializer))
  end

  def destroy
    return error_message unless @event.destroy

    response_success("Event deleted successfully", 200, nil)
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :venue, :description, :start_time, :end_time).merge(user_id: current_user.id)
  end

  def set_event
    @event = current_user.events.find_by(id: params[:id])
    return response_failure("", 422, "Event not found") unless @event
  end

  def error_message
    response_failure("", 422, @event.errors.full_messages[0])
  end

  def remove_existing_job job_id
    scheduled = Sidekiq::ScheduledSet.new
    scheduled.select { |job| job.delete if job_id == job.jid.to_s }
    @event.update(job_id: nil)
  end
end
