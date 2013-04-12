require 'test_helper'

class ProviderContactsControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @provider_contact = provider_contacts(:twitter_nisse)
    @provider = providers(:twitter)
  end

  test "should get index" do
    get :index, :provider_id => @provider.id
    assert_response :success
    assert_not_nil assigns(:provider_contacts)
  end

  test "should get new" do
    get :new, :provider_id => @provider.id
    assert_response :success
  end

  test "should create provider_contact" do
    assert_difference('ProviderContact.count') do
      post :create, :provider_id => @provider.id, provider_contact: { :role => "Administrator"}
    end

    assert_redirected_to provider_contact_path(@provider,assigns(:provider_contact))
  end

  test "should show provider_contact" do
    get :show, id: @provider_contact, :provider_id => @provider.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @provider_contact, :provider_id => @provider.id
    assert_response :success
  end

  test "should update provider_contact" do
    put :update, id: @provider_contact, :provider_id => @provider.id, provider_contact: { :role => "Administrator" }
    assert_redirected_to provider_contact_path(@provider,assigns(:provider_contact))
  end

  test "should destroy provider_contact" do
    assert_difference('ProviderContact.count', -1) do
      delete :destroy, id: @provider_contact, :provider_id => @provider.id
    end

    assert_redirected_to provider_contacts_path(@provider)
  end
end
