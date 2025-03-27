class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.integer     :quantity, default: 1
      t.references  :user
      t.references  :ticket

      t.timestamps
    end
  end
end
