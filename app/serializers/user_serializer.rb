# frozen_string_literal: true
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone_number, :age, :address, :role
end
