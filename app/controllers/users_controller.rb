class UsersController < ApplicationController
  def show
    render json: @current_user
  end

  def logout
    render json: { message: 'Logged out successfully' }
  end

  def apply_leave
    start_date = params[:start_date]
    end_date = params[:end_date]

    if start_date.blank? || end_date.blank?
      render json: { error: 'Please enter start and end dates' }, status: :unprocessable_entity
      return
    end

    begin
      leave_duration = (end_date.to_date - start_date.to_date).to_i + 1

      if leave_duration <= 2
        render json: { message: 'Leave applied successfully' }
      else
        salary_deduction = 200 * (leave_duration - 2)
        @current_user.salary_alloted -= salary_deduction
        @current_user.save

        render json: { message: "Leave applied successfully. Salary deduction: Rs. #{salary_deduction}" }
      end
    rescue Date::Error => e
      render json: { error: 'Invalid date format' }, status: :unprocessable_entity
    end
  end


end
