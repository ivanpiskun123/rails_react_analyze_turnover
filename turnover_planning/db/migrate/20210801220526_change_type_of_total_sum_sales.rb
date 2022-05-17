class ChangeTypeOfTotalSumSales < ActiveRecord::Migration[6.1]
  def change
    add_column :sales, :total_sum, :integer
  end
end
