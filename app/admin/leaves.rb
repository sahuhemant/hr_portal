ActiveAdmin.register Leave do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :start_date, :end_date, :user_id, :reason, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:start_date, :end_date, :user_id, :reason, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
