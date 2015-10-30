class ServicesController < ApplicationController
  # GET /services
  # GET /services.json
  def index
    @show_csv_export_button=true
    params[:order]||='name'
    keys=["name","group","client_count"]
    @services = filter_and_sort(Service.all,keys,params)

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
    params[:order]||='client'
    keys=["client","starts_at"]
    @service=Service.find_by_id(params[:id])
    @subscriptions = filter_and_sort(@service.subscriptions,keys,params)

    respond_to do |format|
      format.html 
      format.json { render json: @subscriptions }
    end
  end

  # GET /services/1/relations
  # GET /services/1/relations.json
  def relations
    params[:order]||='relation_type'
    keys=["relation_type","related_service"]
    @service=Service.find_by_id(params[:id])
    @relations = filter_and_sort(@service.relations,keys,params)

    respond_to do |format|
      format.html 
      format.json { render json: @relations }
    end
  end


  # GET /services/1/backends
  # GET /services/1/backends.json
  def backends
    params[:order]||='name'
    keys=["id","name","service_count"]
    @service=Service.find_by_id(params[:id])
    @backends = filter_and_sort(@service.backends,keys,params)

    respond_to do |format|
      format.html 
      format.json { render json: @backends }
    end
  end

  # GET /services/1/contacts
  # GET /services/1/contacts.json
  def contacts
    @show_email_button=true
    params[:order]||='contact'
    keys=["contact","name","email"]
    @service=Service.find_by_id(params[:id])
    @roles = filter_and_sort(@service.contact_roles,keys,params)

    respond_to do |format|
      format.html 
      format.json { render json: @roles }
    end
  end


end
