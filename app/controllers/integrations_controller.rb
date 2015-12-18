class IntegrationsController < ApplicationController
  # GET /integrations
  # GET /integrations.json
  def index
    params[:order]||='name'
    keys=["name","group","client_count","type"]
    @integrations = filter_and_sort(Integration.all,keys,params)

    respond_to do |format|
      format.html # index.html.erb
      format.csv # index.csv.rb
      format.json { render json: @integrations }
    end
  end

  # GET /integrations/1
  # GET /integrations/1.json
  def show
    @integration=Integration.find_by_id(params[:id])

    respond_to do |format|
      format.html { redirect_to subscriptions_integration_url(@integration) }
      format.json { render json: @integration }
    end
  end

  # GET /integrations/1/subscriptions
  # GET /integrations/1/subscriptions.json
  def subscriptions
    params[:order]||='client'
    keys=["client","starts_at"]
    @integration=Integration.find_by_id(params[:id])
    @subscriptions = filter_and_sort(@integration.subscriptions,keys,params)

    respond_to do |format|
      format.html 
      format.csv 
      format.json { render json: @subscriptions }
    end
  end

  # GET /integrations/1/relations
  # GET /integrations/1/relations.json
  def relations
    params[:order]||='relation_type'
    keys=["relation_type","related_integration","description"]
    @integration=Integration.find_by_id(params[:id])
    @relations = filter_and_sort(@integration.relations,keys,params)

    respond_to do |format|
      format.html 
      format.csv
      format.json { render json: @relations }
    end
  end


  # GET /integrations/1/backends
  # GET /integrations/1/backends.json
  def backends
    params[:order]||='name'
    keys=["id","name","integration_count"]
    @integration=Integration.find_by_id(params[:id])
    @backends = filter_and_sort(@integration.backends,keys,params)

    respond_to do |format|
      format.html 
      format.csv 
      format.json { render json: @backends }
    end
  end

  # GET /integrations/1/contacts
  # GET /integrations/1/contacts.json
  def contacts
    @show_email_button=true
    params[:order]||='contact'
    keys=["contact","name","email"]
    @integration=Integration.find_by_id(params[:id])
    @roles = filter_and_sort(@integration.contact_roles,keys,params)

    respond_to do |format|
      format.html 
      format.csv { render template: "shared/contacts.csv.rb"}
      format.json { render json: @roles }
    end
  end


end
