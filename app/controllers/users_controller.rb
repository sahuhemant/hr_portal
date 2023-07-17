class UsersController < ApplicationController
  before_action :authenticate_request, only: [:apply_leave, :leave_status, :show]
  before_action :authorize_employee, only: :apply_leave
  skip_before_action :authorize_hr

  # Employee own detail

  def show   
    render json: @current_user
  end

  def leave_status
    user = @current_user
    render json: user.leaves
  end
 
  def apply_leave
    start_date = params[:start_date]
    end_date = params[:end_date]
    reason = params[:reason]
    
    leave = Leave.new(start_date: start_date, end_date: end_date, reason: reason, user: @current_user)
  
    if leave.save
      render json: leave
    else
      render json: { error: leave.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def authorize_employee
    unless @current_user.type == 'Employee'
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
  
end
