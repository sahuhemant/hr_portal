class Holiday < ApplicationRecord
  validates :name, presence: true
  # validates :date, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "should be in the format yyyy-mm-dd" }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date", "id", "name", "updated_at"]
  end
end
