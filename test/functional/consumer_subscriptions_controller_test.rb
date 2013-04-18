require 'test_helper'

class ConsumerSubscriptionsControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @consumer = consumers(:beatles)
    @subscription = subscriptions(:beatles_friends)
  end

  test "should get index" do
    get :index, :consumer_id => @consumer.id
    assert_response :success
    assert_not_nil assigns(:subscriptions)
  end

  test "should get new" do
    get :new, :consumer_id => @consumer.id
    assert_response :success
  end

  test "should create subscription and a new service" do
    assert_difference('Subscription.count') do
      post :create,  :consumer_id => @consumer.id, subscription: { service_name: "A new service", :tag_list => "Hej, hello"}
    end

    assert_redirected_to consumer_subscription_path(@consumer,assigns(:subscription))
  end

  test "should show subscription" do
    get :show, id: @subscription, :consumer_id => @consumer.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subscription, :consumer_id => @consumer.id
    assert_response :success
  end

  test "should update subscription" do
    put :update, id: @subscription, :consumer_id => @consumer.id, subscription: { consumer_name: @subscription.consumer.name, :tag_list => "Hej, hello"}
    assert_redirected_to consumer_subscription_path(@consumer,assigns(:subscription))
  end

  test "should destroy subscription" do
    assert_difference('Subscription.count', -1) do
      delete :destroy, id: @subscription, :consumer_id => @consumer.id
    end

    assert_redirected_to consumer_path(@consumer)
  end
end
