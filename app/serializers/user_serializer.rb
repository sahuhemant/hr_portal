class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :fullname, :joining_date, :salary_alloted, :profile_picture, :type, :password

  def profile_picture
    object.profile_picture.url
  end
end