require "test_helper"

class GalleryImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get gallery_images_create_url
    assert_response :success
  end

  test "should get lower" do
    get gallery_images_lower_url
    assert_response :success
  end

  test "should get higher" do
    get gallery_images_higher_url
    assert_response :success
  end

  test "should get destroy" do
    get gallery_images_destroy_url
    assert_response :success
  end
end
