require "test_helper"

class SaleTest < ActiveSupport::TestCase

  test "should not save sale" do
    s = Sale.new
    s.amount = -1
    c.total_sum = 10
    assert_not c.save
end

end
