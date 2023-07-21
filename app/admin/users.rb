ActiveAdmin.register User do
    index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :fullname
    column :salary_alloted
    column :joining_date
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :fullname
      f.input :username
      f.input :salary_alloted
      f.input :joining_date
      f.input :type

    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :username, :password_digest, :joining_date, :salary_alloted, :profile_picture, :email, :fullname, :type
  #
  # or
  #
  # permit_params do
  #   permitted = [:username, :password_digest, :joining_date, :salary_alloted, :profile_picture, :email, :fullname, :type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
