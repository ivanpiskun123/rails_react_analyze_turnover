module Types
  class AveragePriceInMonthType < Types::BaseObject

    field :month_number, Int, null: false
    field :russian_name_of_month, String, null: false
    field :average_sales_price, Float, null: false

  end
end
