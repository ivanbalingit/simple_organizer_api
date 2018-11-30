class CreateReminders < ActiveRecord::Migration[5.2]
  def change
    create_table :reminders do |t|
      t.date :reminder_date
      t.text :details
      t.references :remindable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
