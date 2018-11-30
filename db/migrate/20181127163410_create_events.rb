class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :user
      t.string :name
      t.date :event_date
      t.time :time_start
      t.time :time_end
      t.text :details

      t.timestamps
    end
  end
end
