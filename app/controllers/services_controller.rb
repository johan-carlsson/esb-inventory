class ServicesController < ApplicationController
  # GET /services
  # GET /services.json
  def index
    params[:order]||='services.name'
    @services = Service.all
    @show_csv_export_button=true
    respond_to do |format|
      format.html # index.html.erb
      format.csv # index.csv.rb
      format.json { render json: @services }
    end
  end

  # GET /services/1
  # GET /services/1.json
  def show
    @service=Service.find_by_id(params[:id])

    respond_to do |format|
      format.html { redirect_to subscriptions_service_url(@service) }
      format.json { render json: @service }
    end
  end

  # GET /services/1/subscriptions
  # GET /services/1/subscriptions.json
  def subscriptions
    @service=Service.find_by_id(params[:id])
    @subscriptions=@service.subscriptions

    respond_to do |format|
      format.html 
      format.json { render json: @subscriptions }
    end
  end

end
