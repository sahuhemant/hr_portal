class HolidaysController < ApplicationController
  include JsonWebToken
  skip_before_action :authenticate_request
  before_action :authorize_hr, only: [:create, :destroy, :update]
  before_action :set_params, only: [:show, :destroy, :update]

  def index
    render json: Holiday.all
  end

  def show
   render json: @holiday, status: :ok
  end
  
  def create
    holiday = Holiday.new(holiday_params)
    if holiday.save
      render json: { message: 'Holidays created successfully' }
    else
      render json: { error: holiday.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @holiday.destroy
    render json: { message: 'Holidays deleted successfully' }
  end

  def update
    if @holiday.update(holiday_params)
      render json: @holiday
    else
      render json: { errors: @holiday.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  private
  
  def authorize_hr
    token = request.headers['Authorization'].to_s.split(' ').last
    payload = decode(token)
    render json: { error: 'Unauthorized' }, status: :unauthorized unless payload && payload['user_id'] == 'hr'
  end
  
  def holiday_params
    params.permit( :id, :name, :date )
  end

  def set_params
    @holiday = Holiday.find_by(id: params[:id])
    render json: { message: "holiday not found" }, status: :not_found if @holiday.nil?
  end
end