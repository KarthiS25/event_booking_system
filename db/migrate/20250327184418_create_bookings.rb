class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.integer     :quantity, default: 1
      t.references  :user
      t.references  :ticket
      t.references  :event
      t.datetime    :booked_date_time
      t.string      :reference_number
      t.decimal     :amount, default: 0
      t.string      :job_id

      t.timestamps
    end
  end
end
