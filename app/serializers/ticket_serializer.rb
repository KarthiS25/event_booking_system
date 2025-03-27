# frozen_string_literal: true
class TicketSerializer < ActiveModel::Serializer
  attributes :id, :ticket_type, :price, :quantity
end
