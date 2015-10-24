require 'test_helper'

class SystemsControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @system = systems(:twitter)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:systems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create system" do
    assert_difference('System.count') do
      post :create, system: { name: "A system" , :tag_list => "Hej, hello"}
    end

    assert_redirected_to system_path(assigns(:system))
  end

  test "should show system" do
    get :show, id: @system
    assert_redirected_to system_readme_url(@system) 
  end

  test "should get edit" do
    get :edit, id: @system
    assert_response :success
  end

  test "should update system" do
    put :update, id: @system, system: { name: @system.name , :tag_list => "Hej, hello"}
    assert_redirected_to system_readme_path(assigns(:system))
  end

  test "should destroy system" do
    assert_difference('System.count', -1) do
      delete :destroy, id: @system
    end

    assert_redirected_to systems_path
  end

  test "should show readme" do
    get :readme, system_id: @system
    assert_response :success
  end

  test "should edit readme" do
    get :edit_readme, system_id: @system
    assert_response :success
  end

  test "should update readme" do
    put :update_readme, system_id: @system, readme: { text: "Hello" }
    assert_redirected_to system_readme_path(@system)
  end

end
