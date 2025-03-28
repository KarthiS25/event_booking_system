# frozen_string_literal: true
class TicketSerializer < ActiveModel::Serializer
  attributes :id, :ticket_type, :price, :quantity, :available

  def available
    "#{(object.available / object.quantity.to_f * 100).to_i}% available"
  end
end
