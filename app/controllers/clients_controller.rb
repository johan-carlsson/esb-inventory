class ClientsController < ApplicationController
  # GET /clients
  # GET /clients.json
  def index
    @show_csv_export_button=true
    params[:order] ||= 'name'
    keys=["name","identifier","service_count"]
    @clients = filter_and_sort(Client.all,keys,params)

    respond_to do |format|
      format.html # index.html.erb
      format.csv # index.csv.rb
      format.json { render json: @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find_by_id(params[:id])

    respond_to do |format|
      format.html { redirect_to subscriptions_client_url(@client) }
      format.json { render json: @client }
    end
  end

  # GET /clients/1/subscriptions
  # GET /clients/1/subscriptions.json
  def subscriptions
    params[:order] ||= 'service'
    keys=["service","starts_at"]
    @client = Client.find_by_id(params[:id])
    @subscriptions = filter_and_sort(@client.subscriptions,keys,params)

    respond_to do |format|
      format.html
      format.json { render json: @subscriptions }
    end
  end

  # GET /clients/1/contacts
  # GET /clients/1/contacts.json
  def contacts
    params[:order]||='contact'
    keys=["contact","name","email"]
    @client = Client.find_by_id(params[:id])
    @roles = filter_and_sort(@client.contact_roles,keys,params)

    respond_to do |format|
      format.html 
      format.json { render json: @roles }
    end
  end

end
