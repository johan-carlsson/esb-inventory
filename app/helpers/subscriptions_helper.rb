module SubscriptionsHelper
  def service_subscriptions_table_row_url(services,subscription)
    if current_user
      service_subscription_url(services,subscription)
    else
      consumer_url(subscription.consumer)
    end
  end

  def consumer_subscriptions_table_row_url(services,subscription)
    if current_user
      consumer_subscription_url(services,subscription)
    else
      service_url(subscription.service)
    end
  end
end
