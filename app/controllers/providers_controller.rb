class ProvidersController < ApplicationController
  # GET /providers
  # GET /providers.json
  def index
    params[:order] ||= 'providers.name'
    @providers = Provider.order(params[:order]).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @providers }
    end
  end

  # GET /providers/1
  # GET /providers/1.json
  def show
    @provider = Provider.find(params[:id])

    respond_to do |format|
      format.html { redirect_to provider_services_url(@provider) } 
      format.json { render json: @provider }
    end
  end

  # GET /providers/new
  # GET /providers/new.json
  def new
    @provider = Provider.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @provider }
    end
  end

  # GET /providers/1/edit
  def edit
    @provider = Provider.find(params[:id])
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = Provider.new(params[:provider])

    respond_to do |format|
      if @provider.save
        format.html { redirect_to @provider, notice: 'Provider was successfully created.' }
        format.json { render json: @provider, status: :created, location: @provider }
      else
        format.html { render action: "new" }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /providers/1
  # PUT /providers/1.json
  def update
    @provider = Provider.find(params[:id])

    respond_to do |format|
      if @provider.update_attributes(params[:provider])
        format.html { redirect_to @provider, notice: 'Provider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider = Provider.find(params[:id])
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to providers_url }
      format.json { head :no_content }
    end
  end

  # GET /providers/1/services
  # GET /providers/1/services.json
  def services
    params[:order]||='services.name'
    @show_index_toolbar=true
    @provider = Provider.find(params[:provider_id])
    @services=@provider.services.order(params[:order])
    respond_to do |format|
      format.html # services.html.erb
      format.json { render json: @services }
    end 
  end


  # GET /providers/1/consumers
  # GET /providers/1/consumers.json
  def consumers
    params[:order]||='consumers.name'
    @show_index_toolbar=true
    @provider = Provider.find(params[:provider_id])
    @consumers=@provider.consumers.order(params[:order])
    respond_to do |format|
      format.html # services.html.erb
      format.json { render json: @services }
    end 
  end
end
