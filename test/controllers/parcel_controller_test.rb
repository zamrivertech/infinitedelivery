require "test_helper"

class ParcelControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get parcel_index_url
    assert_response :success
  end
end
