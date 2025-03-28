class Ticket < ApplicationRecord
  belongs_to :event
  has_many :bookings, dependent: :destroy
  after_create :set_available

  enum :ticket_type, { general: 0, premium: 1 }, default: :general

  def set_available
    update(available: quantity)
  end
end
