module SaleHelper
  def payment_method_to_s(sale)
    sale.payment_method ? "Наличными" : "Эл. перевод"
  end

  def trade_form_to_s
    sale.trade_form ? "Опт" : "Розн"
  end
end
