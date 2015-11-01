require 'test_helper'

class IntegrationsControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @integration = integrations(:getFriends)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:integrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create integration" do
    assert_difference('Integration.count') do
      post :create, integration: { name: "A integration" , :tag_list => "Hej, hello"}
    end

    assert_redirected_to integration_path(assigns(:integration))
  end

  test "should show integration" do
    get :show, id: @integration
    assert_redirected_to integration_readme_url(@integration) 
  end

  test "should get edit" do
    get :edit, id: @integration
    assert_response :success
  end

  test "should update integration" do
    put :update, id: @integration, integration: { name: @integration.name , :tag_list => "Hej, hello"}
    assert_redirected_to integration_path(assigns(:integration))
  end

  test "should destroy integration" do
    assert_difference('Integration.count', -1) do
      delete :destroy, id: @integration
    end

    assert_redirected_to integrations_path
  end

  test "should show readme" do
    get :readme, integration_id: @integration
    assert_response :success
  end

  test "should edit readme" do
    get :edit_readme, integration_id: @integration
    assert_response :success
  end

  test "should update readme" do
    put :update_readme, integration_id: @integration, readme: { text: "Hello" }
    assert_redirected_to integration_readme_path(@integration)
  end

end
