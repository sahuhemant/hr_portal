class Leave < ApplicationRecord
  belongs_to :user
  validates :reason, presence: true
end
