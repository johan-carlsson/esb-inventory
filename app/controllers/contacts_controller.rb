class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.json
  def index
    @show_csv_export_button=true
    params[:order] ||= 'name'
    @contacts = sort(Contact.all,params[:order])

    respond_to do |format|
      format.html # index.html.erb
      format.csv # index.csv.rb
      format.json { render json: @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = Contact.find_by_id(params[:id])

    respond_to do |format|
      format.html { redirect_to roles_contact_url(@contact) }
      format.json { render json: @contact }
    end
  end

  # GET /contacts/1/roles
  # GET /contacts/1/roles.json
  def roles
    params[:order] ||= 'name'
    @contact = Contact.find_by_id(params[:id])
    @roles= sort(@contact.roles,params[:order])

    respond_to do |format|
      format.html
      format.json { render json: @roles}
    end
  end

end
