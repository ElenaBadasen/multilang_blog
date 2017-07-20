require 'test_helper'

class ImageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get image_index_url
    assert_response :success
  end

  test "should get new_and_edit" do
    get image_new_url
    assert_response :success
  end

  test "should get create" do
    get image_create_url
    assert_response :success
  end

  test "should get show" do
    get image_show_url
    assert_response :success
  end

  test "should get edit" do
    get image_edit_url
    assert_response :success
  end

  test "should get update" do
    get image_update_url
    assert_response :success
  end

  test "should get destroy" do
    get image_destroy_url
    assert_response :success
  end

end
