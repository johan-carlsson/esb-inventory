class BackendsController < ApplicationController
  # GET /backends
  # GET /backends.json
  def index
    params[:order] ||= 'name'
    keys=["name","identifier","integration_count"]
    @backends = filter_and_sort(Backend.all,keys,params)

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
      format.html { redirect_to integrations_backend_url(@backend) }
      format.json { render json: @backend }
    end
  end

  # GET /backends/1/integrations
  # GET /backends/1/integrations.json
  def integrations
    params[:order] ||= 'name'
    keys=["name","group"]
    @backend = Backend.find_by_id(params[:id])
    @integrations = filter_and_sort(@backend.integrations,keys,params)

    respond_to do |format|
      format.html
      format.json { render json: @integrations }
    end
  end

  # GET /backends/1/contacts
  # GET /backends/1/contacts.json
  def contacts
    params[:order]||='contact'
    keys=["contact","name","email"]
    @backend = Backend.find_by_id(params[:id])
    @roles = filter_and_sort(@backend.contact_roles,keys,params)

    respond_to do |format|
      format.html 
      format.json { render json: @roles }
    end
  end

end
