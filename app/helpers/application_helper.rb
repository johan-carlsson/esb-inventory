module ApplicationHelper

  #Redpill view helpers
  def auto_index(offset=0)
    @currentIndex ||= 0
    offset + @currentIndex += 1
  end

  def shortcut_modifier
    case user_agent when /mac os/i then 'ctrl'
    when /windows/i then 'alt'
    when /linux/i then 'alt'
    else 'alt'
    end
  end

  def user_agent
    request.env['HTTP_USER_AGENT']
  end

  def select_consumers_sidebar_item?
    ["consumers","consumer_subscriptions","consumer_contacts"].include?(controller.controller_name)
  end

  def select_services_sidebar_item?
    ["services","service_subscriptions"].include?(controller.controller_name)
  end

  def select_providers_sidebar_item?
    ["providers","provider_subscriptions"].include?(controller.controller_name)
  end
end
