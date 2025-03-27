class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets, dependent: :destroy
  after_commit :create_tickets

  validates :name, presence: true, length: { in: 2..64 }
  validates :date, presence: true, comparison: { greater_than: Date.today }
  validates :venue, presence: true, length: { in: 2..64 }
  validates :description, presence: true, length: { maximum: 500, message: 'must not exceed 500 characters' }
  validates :start_time, presence: true, comparison: { greater_than: Time.now }
  validates :end_time, presence: true, comparison: { greater_than: Time.now }

  def create_tickets
    return if tickets.any?

    ticket_params = [
      {ticket_type: 0, price: 50, quantity: 2},
      {ticket_type: 1, price: 100, quantity: 2}
    ]
    
    tickets.create(ticket_params)
  end
  
  def self.filter_condition(params)
    return all if params.blank?

    where("name ILIKE :search OR venue ILIKE :search", search: "%#{params[:search]}%")
  end
end
