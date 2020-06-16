require 'test_helper'

class ChatRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chat_rooms_index_url
    assert_response :success
  end

  test "should get new" do
    get chat_rooms_new_url
    assert_response :success
  end

  test "should get create" do
    get chat_rooms_create_url
    assert_response :success
  end

end
