class AddPriceIndexToMonths < ActiveRecord::Migration[6.1]
  def change
    add_column :months, :price_index, :float
  end
end
