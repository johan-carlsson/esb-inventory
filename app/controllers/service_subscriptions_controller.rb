class ServiceSubscriptionsController < SubscriptionsController
  before_filter :get_service
  # GET /service/1/subscriptions
  # GET /service/1/subscriptions.json
  def index
    @subscriptions = @service.subscriptions

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscriptions }
    end
  end


    # GET /service/1/subscriptions/1
  # GET /service/1/subscriptions/1.jsonn
  def show
    @subscription = @service.subscriptions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /service/1/subscriptions/new
  # GET /service/1/subscriptions/new.json
  def new
    @subscription = Subscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /service/1/subscriptions/1/edit
  def edit
    @subscription = @service.subscriptions.find(params[:id])
  end

  # POST /service/1/subscriptions
  # POST /service/1/subscriptions.json
  def create
    @subscription = @service.subscriptions.build(params[:subscription])
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to service_subscription_url(@service,@subscription), notice: 'Subscription was successfully created.' }
        format.json { render json: @subscription, status: :created, location: @subscription }
      else
        format.html { render action: "new" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /service/1/subscriptions/1
  # PUT /service/1/subscriptions/1.json
  def update
    @subscription = @service.subscriptions.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to service_subscription_url(@service,@subscription), notice: 'Subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /service/subscriptions/1
  # DELETE /service/subscriptions/1.json
  def destroy
    @subscription = @service.subscriptions.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :no_content }
    end
  end


  def get_service
    @service=Service.find(params[:service_id])
  end
 
end
