class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :validatable,
         :invitable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist,
         authentication_keys: [:login]

  enum :role, { admin: 0, organizer: 1, user: 2 }, default: :user

  normalizes :email, with: -> email { email.strip.downcase }

  validates :name, length: { in: 2..64 }, allow_blank: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, length: { in: 10..15 }, allow_blank: true
  validates :address, presence: true, length: { maximum: 500, message: 'must not exceed 20 charaters' }

  scope :organizers, -> { where(role: 1) }
end
