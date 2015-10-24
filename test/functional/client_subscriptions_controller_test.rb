require 'test_helper'

class ClientSubscriptionsControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @client = clients(:beatles)
    @subscription = subscriptions(:beatles_friends)
  end

  test "should get index" do
    get :index, :client_id => @client.id
    assert_response :success
    assert_not_nil assigns(:subscriptions)
  end

  test "should get new" do
    get :new, :client_id => @client.id
    assert_response :success
  end

  test "should create subscription and a new service" do
    assert_difference('Subscription.count') do
      post :create,  :client_id => @client.id, subscription: { service_name: "A new service", :tag_list => "Hej, hello"}
    end

    assert_redirected_to client_subscription_path(@client,assigns(:subscription))
  end

  test "should show subscription" do
    get :show, id: @subscription, :client_id => @client.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subscription, :client_id => @client.id
    assert_response :success
  end

  test "should update subscription" do
    put :update, id: @subscription, :client_id => @client.id, subscription: { client_name: @subscription.client.name, :tag_list => "Hej, hello"}
    assert_redirected_to client_subscription_path(@client,assigns(:subscription))
  end

  test "should destroy subscription" do
    assert_difference('Subscription.count', -1) do
      delete :destroy, id: @subscription, :client_id => @client.id
    end

    assert_redirected_to client_path(@client)
  end
end
