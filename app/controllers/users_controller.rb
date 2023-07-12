class UsersController < ApplicationController
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
  
    if start_date.blank? || end_date.blank?
      render json: { error: 'Please enter start and end dates' }, status: :unprocessable_entity
      return
    end

  
    begin
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
    rescue ArgumentError
      render json: { error: 'Invalid date format. Please enter dates in the format yyyy-mm-dd' }, status: :unprocessable_entity
      return
    end
  
    if start_date > end_date
      render json: { error: 'Start date cannot be greater than end date' }, status: :unprocessable_entity
      return
    end
  
    leave = Leave.new(start_date: start_date, end_date: end_date,  reason: reason, user: @current_user)
  
    if leave.save
      render json: { message: 'Leave submited' }
    else
      render json: { error: leave.errors.full_messages }, status: :unprocessable_entity
    end
  end

end
