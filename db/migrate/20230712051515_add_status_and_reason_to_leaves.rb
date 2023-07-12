class AddStatusAndReasonToLeaves < ActiveRecord::Migration[7.0]
  def change
    add_column :leaves, :reason, :text
    add_column :leaves, :status, :string
  end
end
