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

end
