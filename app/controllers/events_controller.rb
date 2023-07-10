class EventsController < ApplicationController
  include JsonWebToken
  skip_before_action :authenticate_request
  before_action :authorize_hr, only: [:create, :index, :destroy]

  def index
    events = Event.all
    render json: events
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
    event = Event.find(params[:id])
    event.destroy
    render json: { message: 'Event deleted successfully' }
  end
  
    private
  
  def authorize_hr
    token = request.headers['Authorization'].to_s.split(' ').last
    payload = decode(token)
    render json: { error: 'Unauthorized' }, status: :unauthorized unless payload && payload['user_id'] == 'hr'
  end
  
  def event_params
    params.permit(:name, :date)
  end
end
  