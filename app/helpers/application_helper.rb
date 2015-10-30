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

  def select_clients_sidebar_item?
    ["clients","client_subscriptions","client_contacts"].include?(controller.controller_name)
  end

  def select_services_sidebar_item?
    ["services","service_subscriptions"].include?(controller.controller_name)
  end

  def select_backends_sidebar_item?
    ["backends"].include?(controller.controller_name)
  end

  def filter_tooltip
    <<-TEXT
Search terms are separated by space
Filter text by regex
Filter numerics by operators
Example "thin.* >2"
Key #{shortcut_modifier}-f
TEXT
    
  end


  def link_to_function(name, function, html_options={})
    onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || '#'
    content_tag(:a, name, html_options.merge(:href => href, :onclick => onclick))
  end
end
