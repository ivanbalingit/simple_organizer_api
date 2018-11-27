class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.references :user
      t.text :note_text

      t.timestamps
    end
  end
end
