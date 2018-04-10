class CreateNoteAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :note_attachments do |t|
      t.integer :note_id
      t.string :avatar

      t.timestamps
    end
  end
end
