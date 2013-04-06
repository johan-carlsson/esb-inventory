class ServiceSubscriptionsController < SubscriptionsController
  def get_subscriber
    @service=Service.find(params[:service_id])
    @subscriber=@service
  end
end
