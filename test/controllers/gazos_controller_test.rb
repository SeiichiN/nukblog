require 'test_helper'

class GazosControllerTest < ActionController::TestCase
  setup do
    @gazo = gazos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gazos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gazo" do
    assert_difference('Gazo.count') do
      post :create, gazo: { comment: @gazo.comment, ctype: @gazo.ctype, file: @gazo.file, image: @gazo.image }
    end

    assert_redirected_to gazo_path(assigns(:gazo))
  end

  test "should show gazo" do
    get :show, id: @gazo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gazo
    assert_response :success
  end

  test "should update gazo" do
    patch :update, id: @gazo, gazo: { comment: @gazo.comment, ctype: @gazo.ctype, file: @gazo.file, image: @gazo.image }
    assert_redirected_to gazo_path(assigns(:gazo))
  end

  test "should destroy gazo" do
    assert_difference('Gazo.count', -1) do
      delete :destroy, id: @gazo
    end

    assert_redirected_to gazos_path
  end
end
