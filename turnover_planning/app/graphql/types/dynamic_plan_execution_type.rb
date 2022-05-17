module Types
  class DynamicPlanExecutionType < Types::BaseObject
    field :month_number, Integer, null: false
    field :russian_name_of_month, String, null: false
    field :sales_plan, Integer, null: false
    field :sales_sum, Integer, null: false
    field :plan_compl_percent, Float, null: false

  end

end
