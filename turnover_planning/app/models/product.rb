class Product < ApplicationRecord

  belongs_to :product_group
  has_many :sales

    validates :name, length: {minimum: 2}

    def sales_sum
      self.sales.to_a.sum(&:total_sum)
    end

    def sales_sum_by_year(year)
      self.sales.of_specific_year_to_array(year).to_a.sum(&:total_sum)
    end

  def to_s
    name
  end

end
