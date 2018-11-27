class CreateSubtasks < ActiveRecord::Migration[5.2]
  def change
    create_table :subtasks do |t|
      t.references :task, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
