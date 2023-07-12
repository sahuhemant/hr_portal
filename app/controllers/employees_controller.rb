class EmployeesController < ApplicationController
  include JsonWebToken
  skip_before_action :authenticate_request
  before_action :authorize_hr
  before_action :set_params, only: [:show, :destroy, :update]
  
  def index
    employees = User.all.map do |i|
      {
        user_id: i.id,
        Fullname: i.fullname,
        username: i.username,
        Email: i.email,
        joining_date: i.joining_date,
        salary_alloted: i.salary_alloted,
        profile_picture: i.profile_picture.url
      }
    end
    render json: employees, status: :ok
  end

  def show
    render json: @employee, status: :ok
  end
  
  def create
    employee = User.new(employee_params)
    employee.profile_picture.attach(params[:profile_picture])
    if employee.save
      render json: employee, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    render json: { message: 'Employee deleted successfully' }
  end

  def update
   if @employee.update(employee_params)
      render json: @employee
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private
  
  def authorize_hr
    token = request.headers['Authorization'].to_s.split(' ').last
    payload = decode(token)
    render json: { error: 'Unauthorized' }, status: :unauthorized unless payload && payload['user_id'] == 'hr'
  end
  
  def employee_params
    params.permit( :id, :fullname, :username, :password, :joining_date, :salary_alloted,  :email )
  end

  def set_params
    @employee = User.find_by(id: params[:id])
    render json: { message: "employee not found" }, status: :not_found if @employee.nil?
  end
end
  