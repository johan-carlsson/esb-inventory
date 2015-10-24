class SystemsController < ApplicationController
  # GET /systems
  # GET /systems.json
  def index
    @show_csv_export_button=true
    params[:order] ||= 'name'
    @systems = sort(System.all,params[:order])

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
      format.json { render json: @system }
    end
  end

  # GET /systems/1/provides
  # GET /systems/1/provides.json
  def provides
    params[:order] ||= 'class'
    @system = System.find_by_id(params[:id])
    @provides= sort(@system.provides,params[:order])

    respond_to do |format|
      format.html
      format.json { render json: @provides }
    end
  end

  # GET /systems/1/contacts
  # GET /systems/1/contacts.json
  def contacts
    params[:order]||='name'
    @system=System.find_by_id(params[:id])
    @roles=sort(@system.contact_roles,params[:order])

    respond_to do |format|
      format.html 
      format.json { render json: @roles }
    end
  end

end
