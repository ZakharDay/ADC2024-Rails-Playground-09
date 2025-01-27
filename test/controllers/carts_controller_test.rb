require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get carts_add_url
    assert_response :success
  end
end
