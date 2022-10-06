class AddIndexToMessages < ActiveRecord::Migration[5.2]
  def change
    add_index :messages, [:chat_id, :message_number], unique: true
  end
end
