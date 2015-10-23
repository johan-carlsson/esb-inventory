class ProvidersController < ApplicationController
  # GET /providers
  # GET /providers.json
  def index
    @show_csv_export_button=true
    params[:order] ||= 'name'
    @providers = sort(Provider.all,params[:order])

    respond_to do |format|
      format.html # index.html.erb
      format.csv # index.csv.rb
      format.json { render json: @providers }
    end
  end

  # GET /providers/1
  # GET /providers/1.json
  def show
    @provider = Provider.find_by_id(params[:id])

    respond_to do |format|
      format.html { redirect_to provides_provider_url(@provider) }
      format.json { render json: @provider }
    end
  end

  # GET /providers/1/provides
  # GET /providers/1/provides.json
  def provides
    params[:order] ||= 'class'
    @provider = Provider.find_by_id(params[:id])
    @provides= sort(@provider.provides,params[:order])

    respond_to do |format|
      format.html
      format.json { render json: @provides }
    end
  end

end
