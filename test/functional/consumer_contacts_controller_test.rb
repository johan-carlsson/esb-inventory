require 'test_helper'

class ConsumerContactsControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @consumer_contact = consumer_contacts(:redpill_nisse)
    @consumer = consumers(:redpill)
  end

  test "should get index" do
    get :index, :consumer_id => @consumer.id
    assert_response :success
    assert_not_nil assigns(:consumer_contacts)
  end

  test "should get new" do
    get :new, :consumer_id => @consumer.id
    assert_response :success
  end

  test "should create consumer_contact" do
    assert_difference('ConsumerContact.count') do
      post :create, :consumer_id => @consumer.id, consumer_contact: { :role => "Administrator", :tag_list => "Hej, Hello"}
    end

    assert_redirected_to consumer_contact_path(@consumer,assigns(:consumer_contact))
  end

  test "should show consumer_contact" do
    get :show, id: @consumer_contact, :consumer_id => @consumer.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @consumer_contact, :consumer_id => @consumer.id
    assert_response :success
  end

  test "should update consumer_contact" do
    put :update, id: @consumer_contact, :consumer_id => @consumer.id, consumer_contact: { :role => "Administrator", :tag_list => "Hej, hello"}
    assert_redirected_to consumer_contact_path(@consumer,assigns(:consumer_contact))
  end

  test "should destroy consumer_contact" do
    assert_difference('ConsumerContact.count', -1) do
      delete :destroy, id: @consumer_contact, :consumer_id => @consumer.id
    end

    assert_redirected_to consumer_contacts_path(@consumer)
  end

end
