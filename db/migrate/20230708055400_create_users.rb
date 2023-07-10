class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.date :joining_date
      t.decimal :salary_alloted

      t.timestamps
    end
  end
end
