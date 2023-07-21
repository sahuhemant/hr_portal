class EventsController < NewController
  skip_before_action :authenticate_request
  before_action :authorize_hr, only: [:create, :destroy, :update]
  before_action :set_params, only: [:destroy, :update]

  # Hr Working 


   def index
    event_name = params[:name] 
    @event = Event.where(' name LIKE ?',"%#{event_name}%")

    if @event.present?
      render json: @event, status: :ok
    else
      render json: { error: 'event not found' }, status: :not_found
    end
  end
  
  def create
    event = Event.new(event_params)
    if event.save
      render json: event, status: :created
    else
      render json: { error: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    render json: @event
  end

  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  private
  

  def event_params
    params.permit( :id, :name, :date )
  end

  def set_params
    @event = Event.find_by(id: params[:id])
    render json: { message: "event not found" }, status: :not_found if @event.nil?
  end

end
  