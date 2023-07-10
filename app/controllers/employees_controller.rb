class EmployeesController < ApplicationController
  include JsonWebToken
  skip_before_action :authenticate_request
  before_action :authorize_hr
  
  def index
    employees = User.all
    render json: employees
  end

  def show
    employee = User.find_by(id: params[:id])
    if employee.nil?
      render json: { message: "employee not found" }
    else
      render json: employee
    end
  end
  
  def create
    employee = User.new(employee_params)
    if employee.save
      render json: employee, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    employee = User.find_by(id: params[:id])
    if employee.nil?
      render json: { message: "Id not found" }
    else
      employee.destroy
      render json: { message: 'Employee deleted successfully' }
    end
  end

  def update
    employee = User.find_by(id: params[:id])
    if employee.nil?
      render json: { message: "Id not found" }
    elsif employee.update(employee_params)
      render json: employee
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private
  
  def authorize_hr
    token = request.headers['Authorization'].to_s.split(' ').last
    payload = decode(token)
    render json: { error: 'Unauthorized' }, status: :unauthorized unless payload && payload['user_id'] == 'hr'
  end
  
  def employee_params
    params.permit( :id, :fullname, :username, :password, :joining_date, :salary_alloted, :profile_picture, :email )
  end
end
  