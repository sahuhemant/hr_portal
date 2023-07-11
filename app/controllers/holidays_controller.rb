class HolidaysController < ApplicationController
  skip_before_action :authenticate_request
 
  def index
    holidays = Holiday.all
    render json: holidays
  end

end