require 'sidekiq-scheduler'

class UpdateChatCounterWorker
  include Sidekiq::Worker

  def perform(*args)
    application_with_chat_count = Chat.group(:application_id).count
    application_with_chat_count.each do |_key, _value|
      Application.where(id: _key).update(chat_count: _value)
    end
  end
end