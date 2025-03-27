class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  after_commit :update_ticket_quantity
  after_destroy :restore_ticket_quantity
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def update_ticket_quantity
    ticket.update(quantity: ticket.quantity - quantity)
  end

  def restore_ticket_quantity
    ticket.update(quantity: ticket.quantity + quantity)
  end
end
