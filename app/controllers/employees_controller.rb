class EmployeesController < NewController
  skip_before_action :authenticate_request
  before_action :authorize_hr
  before_action :set_params, only: [ :destroy, :update ]

  # HR Working regarding Employee
  
   def index
    employee_name = params[:fullname] 
    @employee = User.where(' fullname LIKE ?',"%#{employee_name}%")

    if @employee.present?
      render json: @employee, status: :ok
    else
      render json: { error: 'employee not found' }, status: :not_found
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
    @employee.destroy
    render json: @employee
  end

  def update
   if @employee.update(employee_params)
      render json: @employee
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
 
  def employee_params
    params.permit( :id, :fullname, :username, :password, :joining_date, :salary_alloted,  :email, :profile_picture, :type )
  end

  def set_params
    @employee = User.find_by(id: params[:id])
    render json: { message: "employee not found" }, status: :not_found if @employee.nil?
  end
end
  