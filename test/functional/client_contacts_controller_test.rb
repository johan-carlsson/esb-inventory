require 'test_helper'

class ClientContactsControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @client_contact = client_contacts(:redpill_nisse)
    @client = clients(:redpill)
  end

  test "should get index" do
    get :index, :client_id => @client.id
    assert_response :success
    assert_not_nil assigns(:client_contacts)
  end

  test "should get new" do
    get :new, :client_id => @client.id
    assert_response :success
  end

  test "should create client_contact" do
    assert_difference('ClientContact.count') do
      post :create, :client_id => @client.id, client_contact: { :role => "Administrator", :tag_list => "Hej, Hello"}
    end

    assert_redirected_to client_contact_path(@client,assigns(:client_contact))
  end

  test "should show client_contact" do
    get :show, id: @client_contact, :client_id => @client.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_contact, :client_id => @client.id
    assert_response :success
  end

  test "should update client_contact" do
    put :update, id: @client_contact, :client_id => @client.id, client_contact: { :role => "Administrator", :tag_list => "Hej, hello"}
    assert_redirected_to client_contact_path(@client,assigns(:client_contact))
  end

  test "should destroy client_contact" do
    assert_difference('ClientContact.count', -1) do
      delete :destroy, id: @client_contact, :client_id => @client.id
    end

    assert_redirected_to client_contacts_path(@client)
  end

end
