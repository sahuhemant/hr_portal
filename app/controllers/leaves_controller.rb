class LeavesController < ApplicationController
	skip_before_action :authenticate_request
	before_action :authorize_hr
	before_action :set_params, only: [:show, :update]

  # HR working regarding Leave for Approve
  
  def index
    render json: Leave.all
  end
  
  def show
		render json: @leave, status: :ok
  end
  
  def update
    if @leave.update(leave_params)
      render json: @leave
    else
      render json: { errors: @leave.errors.full_messages }, status: :unprocessable_entity
    end
  end
    
  private

  def leave_params
    params.permit( :reason, :status )
  end

  def set_params
    @leave = Leave.find_by(id: params[:id])
    render json: { message: "leave not found" }, status: :not_found if @leave.nil?
  end
end
