# frozen_string_literal: true
class BookingSerializer < ActiveModel::Serializer
  attributes :id, :event_name, :event_date, :booked_date_time, :reference_number,
             :event_start_time, :event_end_time, :amount

  def event_name
    object.event.name || ""
  end

  def event_date
    object.event.date || ""
  end

  def event_start_time
    object.event.start_time.present? ? object.event.start_time.in_time_zone("Asia/Kolkata").strftime("%H:%M %p") : ""
  end

  def event_end_time
    object.event.end_time.present? ? object.event.end_time.in_time_zone("Asia/Kolkata").strftime("%H:%M %p") : ""
  end
end
