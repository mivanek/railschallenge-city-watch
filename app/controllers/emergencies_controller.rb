class EmergenciesController < ApplicationController
  before_action :find_emergency, only: [:update, :show]

  def create
    @emergency = Emergency.new(emergency_params)

    if @emergency.save
      ResponderDispatcher.new(@emergency).dispatch!
      render 'create', status: 201
    else
      render json: { message: @emergency.errors }, status: 422
    end
  end

  def index
    @emergencies = Emergency.all
  end

  def show
    render_404 if @emergency.nil?
  end

  def update
    @emergency.update(emergency_update_params)
  end

  private

  def emergency_update_params
    params.require(:emergency).permit(:resolved_at, :fire_severity, :police_severity, :medical_severity)
  end

  def emergency_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity)
  end

  def find_emergency
    @emergency = Emergency.find_by(code: params[:code])
  end
end
