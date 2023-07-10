class EventsController < ApplicationController
  include JsonWebToken
  skip_before_action :authenticate_request
  before_action :authorize_hr, only: [:create, :destroy, :update]

  def index
    events = Event.all
    render json: events
  end

  def show
    event = Event.find_by(id: params[:id])
    if event.nil?
      render json: { message: "Event not found" }
    else
      render json: event
    end
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
    event = Event.find_by(id: params[:id])
    if event.nil?
      render json: { message: "Event id not found" }
    else
      event.destroy
      render json: { message: 'Event deleted successfully' }
    end
  end

  def update
    event = Event.find_by(id: params[:id])
    if event.nil?
      render json: { message: "Id not found" }
    elsif event.update(event_params)
      render json: event
    else
      render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
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
end
  