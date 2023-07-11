class Leave < ApplicationRecord
  belongs_to :user
  validates :date, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "should be in the format yyyy-mm-dd" }
  validates :start_date, :end_date, presence: true
  validate :start_date_cannot_be_blank, :end_date_cannot_be_blank


  private

  def start_date_cannot_be_blank
    errors.add(:start_date, 'Enter start date') if start_date.blank?
  end

  def end_date_cannot_be_blank
    errors.add(:end_date, 'Enter end date') if end_date.blank?
  end

end
