class ChangeColumnTypeToUser < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :type, 'Employee'
  end
end
