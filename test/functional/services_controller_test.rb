require 'test_helper'

class ServicesControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @service = services(:getFriends)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service" do
    assert_difference('Service.count') do
      post :create, service: { name: "A service" , :tag_list => "Hej, hello"}
    end

    assert_redirected_to service_path(assigns(:service))
  end

  test "should show service" do
    get :show, id: @service
    assert_redirected_to service_readme_url(@service) 
  end

  test "should get edit" do
    get :edit, id: @service
    assert_response :success
  end

  test "should update service" do
    put :update, id: @service, service: { name: @service.name , :tag_list => "Hej, hello"}
    assert_redirected_to service_path(assigns(:service))
  end

  test "should destroy service" do
    assert_difference('Service.count', -1) do
      delete :destroy, id: @service
    end

    assert_redirected_to services_path
  end

  test "should show readme" do
    get :readme, service_id: @service
    assert_response :success
  end

  test "should edit readme" do
    get :edit_readme, service_id: @service
    assert_response :success
  end

  test "should update readme" do
    put :update_readme, service_id: @service, readme: { text: "Hello" }
    assert_redirected_to service_readme_path(@service)
  end

end
