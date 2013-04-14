require 'test_helper'

class ProvidersControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @provider = providers(:twitter)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:providers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create provider" do
    assert_difference('Provider.count') do
      post :create, provider: { name: "A provider" }
    end

    assert_redirected_to provider_path(assigns(:provider))
  end

  test "should show provider" do
    get :show, id: @provider
    assert_redirected_to provider_readme_url(@provider) 
  end

  test "should get edit" do
    get :edit, id: @provider
    assert_response :success
  end

  test "should update provider" do
    put :update, id: @provider, provider: { name: @provider.name }
    assert_redirected_to provider_readme_path(assigns(:provider))
  end

  test "should destroy provider" do
    assert_difference('Provider.count', -1) do
      delete :destroy, id: @provider
    end

    assert_redirected_to providers_path
  end

  test "should show readme" do
    get :readme, provider_id: @provider
    assert_response :success
  end

  test "should edit readme" do
    get :edit_readme, provider_id: @provider
    assert_response :success
  end

  test "should update readme" do
    put :update_readme, provider_id: @provider, readme: { text: "Hello" }
    assert_redirected_to provider_readme_path(@provider)
  end

end
