require "test_helper"

class EvaluatersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get evaluaters_new_url
    assert_response :success
  end
end
