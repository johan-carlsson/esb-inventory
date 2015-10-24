class ServicesController < ApplicationController
  # GET /services
  # GET /services.json
  def index
    params[:order]||='name'
    @services = sort(Service.all,params[:order])
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
    params[:order]||='client'
    @service=Service.find_by_id(params[:id])
    @subscriptions=sort(@service.subscriptions,params[:order])

    respond_to do |format|
      format.html 
      format.json { render json: @subscriptions }
    end
  end

  # GET /services/1/relations
  # GET /services/1/relations.json
  def relations
    params[:order]||='relation_type'
    @service=Service.find_by_id(params[:id])
    @relations=sort(@service.relations,params[:order])

    respond_to do |format|
      format.html 
      format.json { render json: @relations }
    end
  end


  # GET /services/1/backends
  # GET /services/1/backends.json
  def backends
    params[:order]||='name'
    @service=Service.find_by_id(params[:id])
    @backends=sort(@service.backends,params[:order])

    respond_to do |format|
      format.html 
      format.json { render json: @backends }
    end
  end

  # GET /services/1/contacts
  # GET /services/1/contacts.json
  def contacts
    params[:order]||='name'
    @service=Service.find_by_id(params[:id])
    @roles=sort(@service.contact_roles,params[:order])

    respond_to do |format|
      format.html 
      format.json { render json: @roles }
    end
  end


end
