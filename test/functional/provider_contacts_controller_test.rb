require 'test_helper'

class SystemContactsControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @system_contact = system_contacts(:twitter_nisse)
    @system = systems(:twitter)
  end

  test "should get index" do
    get :index, :system_id => @system.id
    assert_response :success
    assert_not_nil assigns(:system_contacts)
  end

  test "should get new" do
    get :new, :system_id => @system.id
    assert_response :success
  end

  test "should create system_contact" do
    assert_difference('SystemContact.count') do
      post :create, :system_id => @system.id, system_contact: { :role => "Administrator", :tag_list => "Hej, hello"}
    end

    assert_redirected_to system_contact_path(@system,assigns(:system_contact))
  end

  test "should show system_contact" do
    get :show, id: @system_contact, :system_id => @system.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @system_contact, :system_id => @system.id
    assert_response :success
  end

  test "should update system_contact" do
    put :update, id: @system_contact, :system_id => @system.id, system_contact: { :role => "Administrator" , :tag_list => "Hej, hello"}
    assert_redirected_to system_contact_path(@system,assigns(:system_contact))
  end

  test "should destroy system_contact" do
    assert_difference('SystemContact.count', -1) do
      delete :destroy, id: @system_contact, :system_id => @system.id
    end

    assert_redirected_to system_contacts_path(@system)
  end
end
