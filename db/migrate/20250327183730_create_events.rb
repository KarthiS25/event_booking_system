class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string      :name
      t.text        :description
      t.date        :date
      t.datetime    :start_time
      t.datetime    :end_time
      t.string      :venue
      t.references  :user
      t.string      :job_id

      t.timestamps
    end
  end
end
