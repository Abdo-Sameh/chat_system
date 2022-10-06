class AddIndexToChats < ActiveRecord::Migration[5.2]
  def change
    add_index :chats, [:application_id, :chat_number], unique: true
  end
end
