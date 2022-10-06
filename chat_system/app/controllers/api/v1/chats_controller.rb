class Api::V1::ChatsController < ApplicationController
  before_action :set_application
  before_action :set_chat, except: [:create, :index]

  def index
    if @application.nil?
      render json: { error: 'No Application found with token provided' }, status: 400
      return
    end
    render json: @application.chats, status: :ok
  end

  def create
    if @application.nil?
      render json: { error: 'No application found with token provided' }, status: 400
      return
    end

    @application.with_advisory_lock("create_new_chat_lock") do
      chat_number = Rails.cache.read(@application.token)
      chat_number = chat_number.nil? ? Chat.where(application_id: @application.id).maximum(:chat_number) || 0 : chat_number.to_i
      ChatCreationWorker.perform_async({ 'application_id' => @application.id, 'chat_number' => chat_number + 1 })
      Rails.cache.write(@application.token, (chat_number + 1).to_s)
      render json: { chat_number: chat_number + 1 }, status: :created
    end
  end

  def update
    render json: @chat, status: :ok
  end

  def show
    if @chat
      render json: @chat, status: :ok
    else
      render json: { error: 'Unable to find chat' }, status: 404
    end
  end

  def search
    if @chat.nil?
      render json: { error: 'No chat found with number provided' }
      return
    end
    results = @chat.messages.search(search_params[:q], search_params)
    messages = results.map do |r|
      r.merge(r.delete('_source')).merge('id': r.delete('_id'))
    end
    render json: { messages: messages }, status: :ok
  end

  private

  def search_params
    params.permit(:q)
  end

  def set_application
    @application = Application.find_by(token: params[:application_token])
  end

  def set_chat
    if @application
      @chat = Chat.find_by(application_id: @application.id, chat_number: params[:number])
    end
  end

end
