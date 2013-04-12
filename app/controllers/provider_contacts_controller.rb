class ProviderContactsController < ApplicationController
  before_filter :get_provider
  # GET /provider/1/contacts
  # GET /provider/1/contacts.json
  def index
    params[:order] ||= 'provider_contacts.role'
    @provider_contacts = @provider.provider_contacts.includes(:contact).order(params[:order]).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @provider_contacts }
    end
  end

  # GET /provider/1/contacts/1
  # GET /provider/1/contacts/1.json
  def show
    @provider_contact = @provider.provider_contacts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @provider_contact }
    end
  end

  # GET /provider/1/contacts/new
  # GET /provider/1/contacts/new.json
  def new
    @provider_contact = @provider.provider_contacts.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @provider_contact }
    end
  end

  # GET /provider/1/contacts/1/edit
  def edit
    @provider_contact = @provider.provider_contacts.find(params[:id])
  end

  # POST /provider/1/contacts
  # POST /provider/1/contacts.json
  def create
    @provider_contact = @provider.provider_contacts.build(params[:provider_contact])
    respond_to do |format|
      if @provider_contact.save
        format.html { redirect_to provider_contact_url(@provider,@provider_contact), notice: 'Provider contact was successfully created.' }
        format.json { render json: @provider_contact, status: :created, location: @provider_contact }
      else
        format.html { render action: "new" }
        format.json { render json: @provider_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /provider/1/contacts/1
  # PUT /provider/1/contacts/1.json
  def update
    @provider_contact = @provider.provider_contacts.find(params[:id])

    respond_to do |format|
      if @provider_contact.update_attributes(params[:provider_contact])
        format.html { redirect_to provider_contact_url(@provider,@provider_contact), notice: 'Provider contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @provider_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /provider/1/contacts/1
  # DELETE /provider/1/contacts/1.json
  def destroy
    @provider_contact = ProviderContact.find(params[:id])
    @provider_contact.destroy

    respond_to do |format|
      format.html { redirect_to provider_contacts_url }
      format.json { head :no_content }
    end
  end

  def get_provider
    @provider=Provider.find(params[:provider_id])
  end

end
