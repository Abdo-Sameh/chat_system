class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :token
      t.integer :chat_count, default: 0

      t.timestamps
    end
  end
end
