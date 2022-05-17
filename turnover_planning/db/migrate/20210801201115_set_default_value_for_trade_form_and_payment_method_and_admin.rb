class SetDefaultValueForTradeFormAndPaymentMethodAndAdmin < ActiveRecord::Migration[6.1]
  def change
    change_column :sales, :payment_method, :boolean, :default => false
    change_column :sales, :trade_form, :boolean, :default => false
  end
end
