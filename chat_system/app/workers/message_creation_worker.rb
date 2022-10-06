require 'sidekiq-scheduler'

class MessageCreationWorker
  include Sidekiq::Worker

  def perform(args)
    Message.create!(chat_id: args['chat_id'], body: args['body'], message_number: args['message_number'])
  end
end