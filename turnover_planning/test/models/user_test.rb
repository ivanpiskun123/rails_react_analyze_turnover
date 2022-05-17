require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user" do
    p = User.new
    assert_not p.save
end

end
