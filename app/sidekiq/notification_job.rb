require "sidekiq-scheduler"

class NotificationJob
  include Sidekiq::Job
  sidekiq_options queue: 'notification_job'

  def perform(event_id, *args)
    event = Event.find_by(id: event_id)
    return unless event

    bookings = Booking.where(event_id: event_id)
    customer_ids = bookings.pluck(:user_id).uniq
    return if customer_ids.empty?

    customer_ids.each do |customer_id|
      puts "Sending event update notification to customer ##{customer_id} for event ##{event_id}"
    end
  end
end
