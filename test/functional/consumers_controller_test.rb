require 'test_helper'

class ConsumersControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @consumer = consumers(:beatles)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:consumers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create consumer" do
    assert_difference('Consumer.count') do
      post :create, consumer: { name: "Jim", :tag_list => "Hej, hello"}
    end

    assert_redirected_to consumer_path(assigns(:consumer))
  end

  test "should show consumer" do
    get :show, id: @consumer
     assert_redirected_to consumer_readme_path(assigns(:consumer))

  end

  test "should get edit" do
    get :edit, id: @consumer
    assert_response :success
  end

  test "should update consumer" do
    put :update, id: @consumer, consumer: { name: @consumer.name, :tag_list => "Hej, hello"}
    assert_redirected_to consumer_readme_path(assigns(:consumer))
  end

  test "should destroy consumer" do
    assert_difference('Consumer.count', -1) do
      delete :destroy, id: @consumer
    end

    assert_redirected_to consumers_path
  end

  test "should show readme" do
    get :readme, consumer_id: @consumer
    assert_response :success
  end

  test "should edit readme" do
    get :edit_readme, consumer_id: @consumer
    assert_response :success
  end

  test "should update readme" do
    put :update_readme, consumer_id: @consumer, readme: { text: "Hello" }
    assert_redirected_to consumer_readme_path(@consumer)
  end


end
