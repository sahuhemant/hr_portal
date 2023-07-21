class HolidaysController < NewController
  skip_before_action :authenticate_request
  before_action :authorize_hr, only: [:create, :destroy, :update]
  before_action :set_params, only: [ :destroy, :update]

  # Hr Working 

   def index
    holiday_name = params[:name] 
    @holiday = Holiday.where(' name LIKE ?',"%#{holiday_name}%")

    if @holiday.present?
      render json: @holiday, status: :ok
    else
      render json: { error: 'Holiday not found' }, status: :not_found
    end
  end
  
  def create
    holiday = Holiday.new(holiday_params)
    if holiday.save
      render json: holiday, status: :created
    else
      render json: { error: holiday.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @holiday.destroy
    render json: @holiday
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