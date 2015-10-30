class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.json
  def index
    params[:order] ||= 'name'
    keys=["name","email","phone"]
    @contacts = filter_and_sort(Contact.all,keys,params)

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
    @hide_email_button=true
    params[:order] ||= 'name'
    keys=["name","on_name"]
    @contact = Contact.find_by_id(params[:id])
    @roles = filter_and_sort(@contact.roles,keys,params)

    respond_to do |format|
      format.html
      format.json { render json: @roles}
    end
  end

end
