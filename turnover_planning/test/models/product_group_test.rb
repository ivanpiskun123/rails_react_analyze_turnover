require "test_helper"

class ProductGroupTest < ActiveSupport::TestCase
  test "should not save product" do
    p = ProductGroup.new
    p.name='d'
    assert_not p.save
end
end
