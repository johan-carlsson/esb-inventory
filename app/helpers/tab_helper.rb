module TabHelper
  def tab_for(name, options={},html_options={})
    if defined? Redpill::AccessControl
      return unless access_authorized_to_url?(options,html_options)
    end

   klass = if html_options[:selected]==false
              'tab'
            elsif html_options[:selected]==true
              'selected_tab'
            elsif (current_page?(options))
              'selected_tab'
            else
              'tab'
            end    
    html=<<-EOH
    <li class='#{klass}'>
    #{link_to(name, options, html_options)}
    </li>
    EOH
    return html.html_safe
  end
end
