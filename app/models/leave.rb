class Leave < ApplicationRecord
  belongs_to :user
  validates  :reason, :start_date, :end_date, presence: true
  validate :validate_dates

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "end_date", "id", "reason", "start_date", "status", "updated_at", "user_id"]
  end

  private
  
  def validate_dates
    if start_date.present? && end_date.present? && start_date.to_date > end_date.to_date
      errors.add(:base, 'Start date cannot be greater than end date')
    end
  end 
  
end