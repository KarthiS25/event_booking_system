class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.integer     :ticket_type
      t.decimal     :price
      t.integer     :available, default: 0
      t.integer     :quantity, default: 0
      t.references  :event

      t.timestamps
    end
  end
end
