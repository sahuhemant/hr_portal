class EmployeesController < NewController
  skip_before_action :authenticate_request
  before_action :authorize_hr
  before_action :set_params, only: [:show, :destroy, :update]

  # HR Working regarding Employee
  
  def index
    render json: User.all
  end

  def show
    render json: @employee, status: :ok
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
 
  def employee_params
    params.permit( :id, :fullname, :username, :password, :joining_date, :salary_alloted,  :email, :profile_picture, :type )
  end

  def set_params
    @employee = User.find_by(id: params[:id])
    render json: { message: "employee not found" }, status: :not_found if @employee.nil?
  end
end
  