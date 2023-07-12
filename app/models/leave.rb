class Leave < ApplicationRecord
  belongs_to :user
  validates :status, presence: true
  validates :reason, presence: true
end
