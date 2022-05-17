class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.integer :amount
      t.string :total_sum
      t.boolean :payment_method
      t.boolean :trade_form
      t.belongs_to :month
      t.belongs_to :product

      t.timestamps
    end
  end
end
