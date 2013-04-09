class ServiceSubscriptionsController < SubscriptionsController
  def get_subscriber
    @service=Service.find(params[:service_id])
    @subscriber=@service
  end
  def index
    params[:order]||='consumers.name'
    super
  end
end
