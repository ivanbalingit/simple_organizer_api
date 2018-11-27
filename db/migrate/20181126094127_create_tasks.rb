class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :taskable, polymorphic: true, index: true
      t.string :name
      t.date :due_date
      t.text :details

      t.timestamps
    end
  end
end
