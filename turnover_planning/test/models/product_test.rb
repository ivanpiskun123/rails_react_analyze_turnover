require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "should not save product" do
    p = Product.new
    p.name='d'
    assert_not p.save
end

end
