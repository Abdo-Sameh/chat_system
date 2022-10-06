require 'sidekiq-scheduler'

class UpdateMessageCounterWorker
  include Sidekiq::Worker

  def perform(*args)
    chat_with_message_count = Message.group(:chat_id).count
    chat_with_message_count.each do |_key, _value|
      Application.where(id: _key).update(messages_count: _value)
    end
  end
end