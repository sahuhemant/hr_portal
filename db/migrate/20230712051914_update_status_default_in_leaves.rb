class UpdateStatusDefaultInLeaves < ActiveRecord::Migration[7.0]
  def change
    change_column_default :leaves, :status, 'pending'
  end
end
