class ConsumerSubscriptionsController < SubscriptionsController
  def get_subscriber
    @consumer=Consumer.find(params[:consumer_id])
    @subscriber=@consumer
  end
end
