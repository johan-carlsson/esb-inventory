class ConsumerContactsController < ApplicationController
  before_filter :get_consumer
  # GET /consumer/1/contacts
  # GET /consumer/1/contacts.json
  def index
    @consumer_contacts = @consumer.consumer_contacts.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @consumer_contacts }
    end
  end

  # GET /consumer/1/contacts/1
  # GET /consumer/1/contacts/1.json
  def show
    @consumer_contact = @consumer.consumer_contacts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @consumer_contact }
    end
  end

  # GET /consumer/1/contacts/new
  # GET /consumer/1/contacts/new.json
  def new
    @consumer_contact = @consumer.consumer_contacts.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @consumer_contact }
    end
  end

  # GET /consumer/1/contacts/1/edit
  def edit
    @consumer_contact = @consumer.consumer_contacts.find(params[:id])
  end

  # POST /consumer/1/contacts
  # POST /consumer/1/contacts.json
  def create
    @consumer_contact = @consumer.consumer_contacts.build(params[:consumer_contact])
    respond_to do |format|
      if @consumer_contact.save
        format.html { redirect_to consumer_contact_url(@consumer,@consumer_contact), notice: 'Consumer contact was successfully created.' }
        format.json { render json: @consumer_contact, status: :created, location: @consumer_contact }
      else
        format.html { render action: "new" }
        format.json { render json: @consumer_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /consumer/1/contacts/1
  # PUT /consumer/1/contacts/1.json
  def update
    @consumer_contact = @consumer.consumer_contacts.find(params[:id])

    respond_to do |format|
      if @consumer_contact.update_attributes(params[:consumer_contact])
        format.html { redirect_to consumer_contact_url(@consumer,@consumer_contact), notice: 'Consumer contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @consumer_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consumer/1/contacts/1
  # DELETE /consumer/1/contacts/1.json
  def destroy
    @consumer_contact = ConsumerContact.find(params[:id])
    @consumer_contact.destroy

    respond_to do |format|
      format.html { redirect_to consumer_contacts_url }
      format.json { head :no_content }
    end
  end

  def get_consumer
    @consumer=Consumer.find(params[:consumer_id])
  end

end
