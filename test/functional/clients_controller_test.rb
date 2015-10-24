require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  setup do
    login_as(:admin)
    @client = clients(:beatles)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client" do
    assert_difference('Client.count') do
      post :create, client: { name: "Jim", :tag_list => "Hej, hello"}
    end

    assert_redirected_to client_path(assigns(:client))
  end

  test "should show client" do
    get :show, id: @client
     assert_redirected_to client_readme_path(assigns(:client))

  end

  test "should get edit" do
    get :edit, id: @client
    assert_response :success
  end

  test "should update client" do
    put :update, id: @client, client: { name: @client.name, :tag_list => "Hej, hello"}
    assert_redirected_to client_readme_path(assigns(:client))
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete :destroy, id: @client
    end

    assert_redirected_to clients_path
  end

  test "should show readme" do
    get :readme, client_id: @client
    assert_response :success
  end

  test "should edit readme" do
    get :edit_readme, client_id: @client
    assert_response :success
  end

  test "should update readme" do
    put :update_readme, client_id: @client, readme: { text: "Hello" }
    assert_redirected_to client_readme_path(@client)
  end


end
