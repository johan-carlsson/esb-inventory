class SystemsController < ApplicationController
  # GET /systems
  # GET /systems.json
  def index
    params[:order] ||= 'name'
    keys=["name","group","identifier","provide_count"]
    @systems = filter_and_sort(System.all,keys,params)

    respond_to do |format|
      format.html # index.html.erb
      format.csv # index.csv.rb
      format.json { render json: @systems }
    end
  end

  # GET /systems/1
  # GET /systems/1.json
  def show
    @system = System.find_by_id(params[:id])

    respond_to do |format|
      format.html { redirect_to provides_system_url(@system) }
      format.csv # index.csv.rb
      format.json { render json: @system }
    end
  end

  # GET /systems/1/provides
  # GET /systems/1/provides.json
  def provides
    params[:order] ||= 'class'
    keys=["class","name"]
    @system = System.find_by_id(params[:id])
    @provides = filter_and_sort(@system.provides,keys,params)

    respond_to do |format|
      format.html
      format.csv # index.csv.rb
      format.json { render json: @provides }
    end
  end

  # GET /systems/1/contacts
  # GET /systems/1/contacts.json
  def contacts
    @show_email_button=true
    params[:order]||='contact'
    keys=["contact","name","email"]
    @system = System.find_by_id(params[:id])
    @roles = filter_and_sort(@system.contact_roles,keys,params)

    respond_to do |format|
      format.html 
      format.csv  {render :template => "shared/contacts.csv.rb"}
      format.json { render json: @roles }
    end
  end

end
