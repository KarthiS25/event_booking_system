# frozen_string_literal: true
class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :date, :venue, :organizer, :tickets, :start_time, :end_time, :description
    
  has_many :tickets

  def organizer
    object.user.name || ""
  end

  def start_time
    object.start_time.present? ? object.start_time.in_time_zone("Asia/Kolkata").strftime("%H:%M %p") : ""
  end

  def end_time
    object.end_time.present? ? object.end_time.in_time_zone("Asia/Kolkata").strftime("%H:%M %p") : ""
  end
end
