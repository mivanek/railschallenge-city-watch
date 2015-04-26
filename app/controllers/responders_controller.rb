class RespondersController < ApplicationController
  before_action :find_responder, only: [:show, :update]

  def create
    @responder = Responder.new(responder_params)

    if @responder.save
      render 'create', status: 201
    else
      render json: { message: @responder.errors }, status: 422
    end
  end

  def index
    render 'capacity' if params[:show] == 'capacity'
    @responders = Responder.all
  end

  def show
    render_404 if @responder.nil?
  end

  def update
    @responder.update(responder_update_params)
  end

  private

  def responder_update_params
    params.require(:responder).permit(:on_duty)
  end

  def responder_params
    params.require(:responder).permit(:name, :type, :capacity)
  end

  def find_responder
    @responder = Responder.find_by(name: params[:name])
  end
end
