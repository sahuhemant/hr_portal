class HolidaysController < ApplicationController
  include JsonWebToken
  skip_before_action :authenticate_request
  before_action :authorize_hr, only: [:create, :destroy, :update]
  before_action :set_params, only: [:show, :destroy, :update]

  # Hr Working 

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

  
  def holiday_params
    params.permit( :id, :name, :date )
  end

  def set_params
    @holiday = Holiday.find_by(id: params[:id])
    render json: { message: "holiday not found" }, status: :not_found if @holiday.nil?
  end
end