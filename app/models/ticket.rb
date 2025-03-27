class Ticket < ApplicationRecord
  belongs_to :event
  has_many :bookings, dependent: :destroy

  enum :ticket_type, { general: 0, premium: 1 }, default: :general

end
