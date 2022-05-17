module Queries
  class ProductGroupSales < Queries::BaseQuery
  description "Query that retrives data for product group's sales scructure report"

    # but how to make it accessiable for query in graphiql?
    type GraphQL::Types::JSON, null: false

    def resolve
      ::ProductGroup.all.map {|pg| [pg.name, pg.sales_sum_by_year(year)] }
    end
  end
end
