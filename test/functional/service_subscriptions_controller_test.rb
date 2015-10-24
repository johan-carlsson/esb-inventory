require 'test_helper'

class ServiceSubscriptionsControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @service = services(:getFriends)
    @subscription = subscriptions(:beatles_friends)
  end

  test "should get index" do
    get :index, :service_id => @service.id
    assert_response :success
    assert_not_nil assigns(:subscriptions)
  end

  test "should get new" do
    get :new, :service_id => @service.id
    assert_response :success
  end

  test "should create subscription and a new client" do
    assert_difference('Subscription.count') do
      post :create,  :service_id => @service.id, subscription: { client_name: "A new client" , :tag_list => "Hej, hello"}
    end

    assert_redirected_to service_subscription_path(@service,assigns(:subscription))
  end

  test "should show subscription" do
    get :show, id: @subscription, :service_id => @service.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subscription, :service_id => @service.id
    assert_response :success
  end

  test "should update subscription" do
    put :update, id: @subscription, :service_id => @service.id, subscription: { client_name: @subscription.client.name , :tag_list => "Hej, hello"}
    assert_redirected_to service_subscription_path(@service,assigns(:subscription))
  end

  test "should destroy subscription" do
    assert_difference('Subscription.count', -1) do
      delete :destroy, id: @subscription, :service_id => @service.id
    end

    assert_redirected_to service_path(@service)
  end
end
