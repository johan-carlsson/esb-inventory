class ServicesController < ApplicationController
  # GET /services
  # GET /services.json
  def index
    params[:order]||='services.name'
    @services = Service.order(params[:order]).page(params[:page])
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
    @service = Service.find(params[:id])

    respond_to do |format|
      format.html { redirect_to service_readme_url(@service) }
      format.json { render json: @service }
    end
  end

  # GET /services/new
  # GET /services/new.json
  def new
    @service = Service.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service }
    end
  end

  # GET /services/1/edit
  def edit
    @service = Service.find(params[:id])
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(params[:service])

    respond_to do |format|
      if @service.save
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
        format.json { render json: @service, status: :created, location: @service }
      else
        format.html { render action: "new" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /services/1
  # PUT /services/1.json
  def update
    @service = Service.find(params[:id])

    respond_to do |format|
      if @service.update_attributes(params[:service])
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service = Service.find(params[:id])
    @service.destroy

    respond_to do |format|
      format.html { redirect_to services_url }
      format.json { head :no_content }
    end
  end

  # GET /services/1/readme
  # GET /services/1/readme.json
  def readme
    @service = Service.find(params[:service_id])
    @readme=@service.readme
    respond_to do |format|
      format.html
      format.json { render json: @readme }
    end
  end


  # GET /services/1/edit_readme
  def edit_readme
    @service = Service.find(params[:service_id])
    @readme = @service.readme || Readme.create
    @service.readme=@readme
    @service.save!
  end

  # PUT /services/1/update_readme
  # PUT /services/1/update_readme.json
  def update_readme
    @service = Service.find(params[:service_id])

    respond_to do |format|
      if @service.readme.update_attributes(params[:readme])
        format.html { redirect_to service_readme_url(@service), notice: 'ReadMe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit_readme" }
        format.json { render json: @readme.errors, status: :unprocessable_entity }
      end
    end
  end
end
