class CreateMonths < ActiveRecord::Migration[6.1]
  def change
    create_table :months do |t|
      t.date :date
      t.integer :sales_plan

      t.timestamps
    end
  end
end
