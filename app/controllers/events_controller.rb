class EventsController < ApplicationController
  include JsonWebToken
  skip_before_action :authenticate_request
  before_action :authorize_hr, only: [:create, :destroy, :update]
  before_action :set_params, only: [:show, :destroy, :update]

  def index
    render json: Event.all
  end

  def show
    render json: @event, status: :ok
  end
  
  def create
    event = Event.new(event_params)
    if event.save
      render json: { message: 'Event created successfully' }
    else
      render json: { error: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    render json: { message: 'Event deleted successfully' }
  end

  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  private
  
  def authorize_hr
    token = request.headers['Authorization'].to_s.split(' ').last
    payload = decode(token)
    render json: { error: 'Unauthorized' }, status: :unauthorized unless payload && payload['user_id'] == 'hr'
  end
  
  def event_params
    params.permit( :id, :name, :date )
  end

  def set_params
    @event = Event.find_by(id: params[:id])
    render json: { message: "event not found" }, status: :not_found if @event.nil?
  end

end
  