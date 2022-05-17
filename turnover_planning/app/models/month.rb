class Month < ApplicationRecord

  # optional, for educational purposes. Insted must be used just method for retrieving previous month
  scope :previous_month, ->(month) { where(date: (month.date-1.month).end_of_month  ) }
  # Months of specified year
  scope :of_specific_year, ->(year) { where( date: ( Date.parse("1-1-#{year}").beginning_of_year .. Date.parse("1-1-#{year}").end_of_year ) ) }

  before_save :date_to_month_start
  before_save :check_date_uniqueness

  has_many :sales, dependent: :destroy

  validates :date, :sales_plan, :price_index, presence: true

  validates :sales_plan, inclusion: { in: 1..99999999999 ,
            message: "(%{value}) can't be less 1 and more 99999999999" }

  validates :price_index, numericality: { greater_than_or_equal_to: 0.00001, less_than_or_equal_to: 99999999999}



  def month_number
    self.date.month
  end

  def sales_sum
    self.sales.to_a.sum(&:total_sum)
  end

  def plan_compl_percent
     (self.sales_sum.to_f / self.sales_plan).round(4)
  end

  def sales_sum_indexed
    (self.sales_sum.to_f / self.price_index).round(2)
  end

  def growth_rate_percent
    if self.date.month == 1
      100.0
    else
      ((self.sales_sum_indexed / Month.previous_month(self).first.sales_sum_indexed )*100).round(2)
    end
  end

  def rate_of_increase_percent
    if self.date.month == 1
      0
    else
      (self.growth_rate_percent - Month.previous_month(self).first.growth_rate_percent).round(2)
    end
  end

  def  average_sales_price
    (  self.sales.to_a.sum(&:product_unit_price)  / self.sales.count).round(2)
  end

  def russian_name_of_month
    Months::RussianMonths.new(self.date.month-1).call
  end


  def to_s
    "#{self.date.strftime("%B , %Y")}"
  end

  private

  def date_to_month_start
    self.date = self.date.end_of_month
  end

  def check_date_uniqueness
    if Month.where(:date => self.date).exists?
      errors.add(:base, " Месяц с указанной датой уже существует")
      throw(:abort)
    end
  end



end
