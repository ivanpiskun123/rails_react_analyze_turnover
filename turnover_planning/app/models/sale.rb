class Sale < ApplicationRecord

  enum payment_method: {
    in_cash: true,
    in_transaction: false
  }

  enum trade_form: {
    is_wholesale: true,
    is_retail: false
  }

  # Sales of specified year
  scope :of_specific_year_to_array, ->(year) { all.select { |s| ( Date.parse("1-1-#{year}").beginning_of_year .. Date.parse("1-1-#{year}").end_of_year ).include?(s.month.date) } }
  scope :of_specific_year, ->(year) {  joins(:month).where( month: { date: ( Date.parse("1-1-#{year}").beginning_of_year .. Date.parse("1-1-#{year}").end_of_year ) } ) }

 belongs_to :month
 belongs_to :product

 validates :total_sum, presence: true
 validates :amount, presence: true

 validates :amount, inclusion: { in: 1..99999999999 ,
           message: "(%{value}) can't be less 1 and more 99999999999" }

 validates :total_sum, inclusion: { in: 1..99999999999 ,
           message: "(%{value}) can't be less 1 and more 99999999999" }

 def product_unit_price
   (self.total_sum.to_f / self.amount).round(2)
 end


  def to_s
    "#{self.month.date.strftime("%B %d, %Y")}-#{self.amount} ед.-#{self.product.name}"
  end



end
