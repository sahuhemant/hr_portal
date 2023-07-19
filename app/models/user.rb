class User < ApplicationRecord
  has_many :leaves, class_name: 'Leave', dependent: :destroy
  has_one_attached :profile_picture
  has_secure_password
  validates :type, inclusion: { in: %w[Employee Hr], message: 'should be Employee' }
  validates :fullname, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, message: "must be a valid email address" }
  validates :salary_alloted, presence: true
  validates :joining_date, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "should be in the format yyyy-mm-dd" }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "fullname", "password_digest" ,"id", "joining_date", "salary_alloted", "type", "updated_at", "username"]
  end
   def self.ransackable_associations(auth_object = nil)
    ["leaves", "profile_picture_attachment_id_eq"]
  end
end
