require 'test_helper'

class IntegrationSubscriptionsControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @integration = integrations(:getFriends)
    @subscription = subscriptions(:beatles_friends)
  end

  test "should get index" do
    get :index, :integration_id => @integration.id
    assert_response :success
    assert_not_nil assigns(:subscriptions)
  end

  test "should get new" do
    get :new, :integration_id => @integration.id
    assert_response :success
  end

  test "should create subscription and a new client" do
    assert_difference('Subscription.count') do
      post :create,  :integration_id => @integration.id, subscription: { client_name: "A new client" , :tag_list => "Hej, hello"}
    end

    assert_redirected_to integration_subscription_path(@integration,assigns(:subscription))
  end

  test "should show subscription" do
    get :show, id: @subscription, :integration_id => @integration.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subscription, :integration_id => @integration.id
    assert_response :success
  end

  test "should update subscription" do
    put :update, id: @subscription, :integration_id => @integration.id, subscription: { client_name: @subscription.client.name , :tag_list => "Hej, hello"}
    assert_redirected_to integration_subscription_path(@integration,assigns(:subscription))
  end

  test "should destroy subscription" do
    assert_difference('Subscription.count', -1) do
      delete :destroy, id: @subscription, :integration_id => @integration.id
    end

    assert_redirected_to integration_path(@integration)
  end
end
