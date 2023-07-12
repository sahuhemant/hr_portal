class User < ApplicationRecord
  has_many :leaves, class_name: 'Leave'
  has_secure_password
  validates :fullname, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: "must be a valid email address" }
  validates :salary_alloted, presence: true
  validates :joining_date, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "should be in the format yyyy-mm-dd" }
  validates :profile_picture, presence: true
end
