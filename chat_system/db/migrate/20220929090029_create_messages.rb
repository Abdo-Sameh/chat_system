class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :message_number
      t.text :body
      t.references :chat, foreign_key: true

      t.timestamps
    end
  end
end
