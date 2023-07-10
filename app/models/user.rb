class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :salary_alloted, presence: true
  #validates :password, presence: true
  validates :joining_date, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "should be in the format yyyy-mm-dd" }

  # has_one_attached :profile_picture
end
