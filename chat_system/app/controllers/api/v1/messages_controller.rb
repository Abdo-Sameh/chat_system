class Api::V1::MessagesController < ApplicationController
  before_action :set_application
  before_action :set_chat
  before_action :set_message, except: [:create, :index]

  def index
    if @application.nil?
      render json: { error: 'No Application found with token provided' }, status: 400
      return
    end
    if @chat.nil?
      render json: { error: 'No Chat found with number provided' }, status: 400
      return
    end
    render :json => @chat.messages, status: :ok
  end

  def create
    if @application == nil
      render json: { error: 'No application found with token provided' }, status: 400
      return
    end
    if @chat == nil
      render json: { error: 'No Chat found with id provided' }, status: 400
      return
    end
    @chat.with_advisory_lock("create_new_message_lock") do
      message_number = Rails.cache.read(@application.token + ":" + @chat.id.to_s)
      message_number = message_number.nil? ? Message.where(chat_id: @chat.id).maximum(:message_number) || 0 : message_number.to_i
      MessageCreationWorker.perform_async({ 'chat_id' => @chat.id, 'body' => params[:body], 'message_number' => message_number + 1 })
      Rails.cache.write(@application.token + ":" + @chat.id.to_s, (message_number + 1).to_s)
      render json: { message_number: message_number + 1 }, status: :created
    end
  end

  def update
    if @message.update({ :body => params[:body] })
      render json: @message
    else
      render json: { error: 'Unable to update message' }, status: 400
    end
  end

  def show
    if @message
      render json: @message, status: :ok
    else
      render json: { error: 'Unable to find message' }, status: 404
    end
  end

  private

  def message_params
    params.permit(:body)
  end

  def set_application
    @application = Application.find_by(token: params[:application_token])
  end

  def set_chat
    if @application
      @chat = Chat.find_by(application_id: @application.id, chat_number: params[:chat_number])
    end
  end

  def set_message
    if @chat
      @message = Message.find_by(chat_id: @chat.id, message_number: params[:number])
    end
  end
end
