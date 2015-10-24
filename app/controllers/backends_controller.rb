class BackendsController < ApplicationController
  # GET /backends
  # GET /backends.json
  def index
    @show_csv_export_button=true
    params[:order] ||= 'name'
    @backends = sort(Backend.all,params[:order])

    respond_to do |format|
      format.html # index.html.erb
      format.csv # index.csv.rb
      format.json { render json: @backends }
    end
  end

  # GET /backends/1
  # GET /backends/1.json
  def show
    @backend = Backend.find_by_id(params[:id])

    respond_to do |format|
      format.html { redirect_to services_backend_url(@backend) }
      format.json { render json: @backend }
    end
  end

  # GET /backends/1/services
  # GET /backends/1/services.json
  def services
    params[:order] ||= 'name'
    @backend = Backend.find_by_id(params[:id])
    @services= sort(@backend.services,params[:order])

    respond_to do |format|
      format.html
      format.json { render json: @services }
    end
  end

  # GET /backends/1/contacts
  # GET /backends/1/contacts.json
  def contacts
    params[:order]||='name'
    @backend=Backend.find_by_id(params[:id])
    @roles=sort(@backend.contact_roles,params[:order])

    respond_to do |format|
      format.html 
      format.json { render json: @roles }
    end
  end

end
