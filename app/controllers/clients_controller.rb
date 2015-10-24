class ClientsController < ApplicationController
  # GET /clients
  # GET /clients.json
  def index
    @show_csv_export_button=true
    params[:order] ||= 'name'
    @clients = sort(Client.all,params[:order])

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
    @client = Client.find_by_id(params[:id])
    @subscriptions= sort(@client.subscriptions,params[:order])

    respond_to do |format|
      format.html
      format.json { render json: @subscriptions }
    end
  end

end
