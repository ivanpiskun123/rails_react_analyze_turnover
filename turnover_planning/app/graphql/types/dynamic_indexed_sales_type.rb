module Types
  class DynamicIndexedSalesType < Types::BaseObject
    field :month_number, Integer, null: false
    field :russian_name_of_month, String, null: false
    field :sales_sum, Integer, null: false
    field :price_index, Float, null: false
    field :sales_sum_indexed, Float, null: false
    field :growth_rate_percent, Float, null: false
    field :rate_of_increase_percent, Float, null: false

  end
end
