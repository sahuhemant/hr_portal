class HolidaysController < ApplicationController
  skip_before_action :authenticate_request
 
  def index
    render json: Holiday.all
  end

end