require "sidekiq-scheduler"

class BookingConfirmationJob
  include Sidekiq::Job
  sidekiq_options queue: 'booking_confirmation_job'

  def perform(booking_id, *args)
    puts "Sending confirmation email for booking ##{booking_id}"
  end
end
