class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ticket
  belongs_to :event

  after_create :update_ticket_quantity
  after_destroy :restore_ticket_quantity

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def update_ticket_quantity
    amount = ticket.price * quantity
    update(amount: amount)
    ticket.update(available: ticket.quantity - quantity)
    BookingConfirmationJob.perform_at(Time.zone.now, self.id)
  end

  def restore_ticket_quantity
    ticket.update(available: ticket.available + quantity)
  end
end
