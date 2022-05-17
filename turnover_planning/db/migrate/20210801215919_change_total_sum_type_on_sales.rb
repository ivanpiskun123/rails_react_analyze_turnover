class ChangeTotalSumTypeOnSales < ActiveRecord::Migration[6.1]
  def change

    remove_column :sales, :total_sum
  end
end
