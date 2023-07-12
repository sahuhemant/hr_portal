class LeavesController < ApplicationController
	skip_before_action :authenticate_request
	before_action :authorize_hr
  
  def index
    render json: Leave.all
  end
  
  def show
    leave = Leave.find_by(id: params[:id])
    if leave.nil?
      render json: { message: 'Leave not found' }
    else
      render json: leave
    end
  end
  
  def update
    leave = Leave.find_by(id: params[:id])
    if leave.nil?
      render json: { message: 'Leave not found' }
    else
      leave.status = params[:status]
      if leave.status .blank?
      	render json: { error: 'Please enter status' }, status: :unprocessable_entity
      else
      leave.save
      render json: { message: 'Leave status Replied successfully' }
    	end
  	end
  end
    
  private

  def authorize_hr
    token = request.headers['Authorization'].to_s.split(' ').last
    payload = decode(token)
    render json: { error: 'Unauthorized' }, status: :unauthorized unless payload && payload['user_id'] == 'hr'
  end
  
end
