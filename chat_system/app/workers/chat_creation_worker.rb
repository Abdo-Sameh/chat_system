require 'sidekiq-scheduler'

class ChatCreationWorker
  include Sidekiq::Worker

  def perform(args)
    Chat.create!(application_id: args['application_id'], chat_number: args['chat_number'])
  end
end