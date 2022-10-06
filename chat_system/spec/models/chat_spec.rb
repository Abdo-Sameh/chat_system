require 'rails_helper'

RSpec.describe Chat, type: :model do
  before(:all) do
    @application = Application.create(name: "Netflix", token: SecureRandom.hex(16))
    @chat = Chat.create(chat_number: 1)
  end

  it 'checks that a chat can be created' do
    expect(@chat).to be_valid
  end

  it 'checks that a chat can be read' do
    expect(Chat.find_by_chat_number(1)).to eq(@chat)
  end

  it 'checks that a chat can be destroyed' do
    @chat.destroy
    expect(Application.chats).to eq(0)
  end
end
