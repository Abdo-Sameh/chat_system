class Api::V1::ApplicationsController < ApplicationController
  before_action :set_application, except: %i[index, create]

  def index
    render Application.all, status: :ok
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      render json: @application, status: :created
    else
      render error: { error: 'Unable to create Application' }, status: 400
    end
  end

  def update
    if @application.update(application_params)
      render json: @application, status: :ok
    else
      render json: { error: 'Unable to update Application' }, status: 400
    end
  end

  def show
    if @application
      render json: @application, status: :ok
    else
      render json: { error: 'Unable to find application' }, status: 404
    end
  end
  
  private

  def application_params
    params.permit(:name)
  end

  def set_application
    @application = Application.find_by!(token: params[:token])
  end
end
