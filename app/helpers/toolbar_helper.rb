module ToolbarHelper
  def redpill_toolbar(options={},&block)
    if options[:type].to_s == "item_toolbar"
      options[:class] ||= 'item_toolbar'
      options[:wrapper_class] ||= 'item_toolbar_wrapper'
    else #type == classic
      options[:class] ||= 'toolbar'
      options[:wrapper_class] ||= 'toolbar_wrapper'
    end

    html=<<-HTML 
    <div class='#{options[:wrapper_class]}'><ul class='#{options[:class]}'>         #{capture(Toolbar.new(self),&block)}
    </ul></div>
    HTML
    return html.html_safe
  end

  def redpill_toolbar_stylesheets()
    return stylesheet_link_tag "redpill_toolbar","redpill_item_toolbar", :plugin => "redpill_toolbar"
  end

  class Toolbar           
    def initialize(actionview_base)
      @base = actionview_base
    end

    def item(options ={}, link_options ={}, link_html_options ={}, disabled=false, active=false)
      if defined? Redpill::AccessControl
        return unless @base.access_authorized_to_url?(link_options,link_html_options)
      end
      link_html_options.merge!(:class => 'disabled') if disabled
      link_html_options.merge!(:class => 'selected') if active
      if disabled
        html=<<-EOH
          <li class="#{options[:class]}" title="#{options[:tooltip]}" >
          <a class="disabled"></a>
          </li>
        EOH
      else
        html=<<-EOH
          <li class="#{options[:class]}" title="#{options[:tooltip]}" >
        #{@base.link_to("",  link_options, link_html_options)}
          </li>
        EOH
      end
      return html.html_safe
    end

    def remote_item(options ={}, link_options ={},link_html_options ={},disabled=false,active=false)
      if defined? Redpill::AccessControl
        return unless @base.access_authorized_to_url?(link_options[:url],link_html_options)
      end
      link_html_options.merge!(:class  => 'disabled') if disabled
      link_html_options.merge!(:class  => 'active') if active
      if disabled
        html=<<-EOH
          <li class="#{options[:class]}" title="#{options[:tooltip]}" >
          <a class="disabled"></a>
          </li>
        EOH
      else
        html=<<-EOH
          <li class="#{options[:class]}" title="#{options[:tooltip]}" >
        #{@base.link_to("",  link_options,link_html_options)}
          </li>
        EOH
      end
      return html.html_safe
    end

    def function(function_name,options ={}, disabled=false, active=false)
      options.merge!(:class => 'disabled') if disabled
      options.merge!(:class => 'selected') if active
      if disabled
        html=<<-EOH
          <li class="#{options[:class]}" title="#{options[:tooltip]}" >
          <a class="disabled"></a>
          </li>
        EOH
      else
        html=<<-EOH
          <li class="#{options[:class]}" title="#{options[:tooltip]}" >
        #{@base.link_to_function("",function_name, options)}
          </li>
        EOH
      end
      return html.html_safe
    end

    #todo rename to text_item
    def text(text, options ={})
      html=<<-EOH
      <li class="toolbar_item_text  #{options[:class]}">#{text}</li>
      EOH
      return html.html_safe
    end

    # todo rename to image_item
    def image(image)
      html=<<-HTML
      <span class='image'>#{@base.image_tag(image,:alt  => '')}</span>
      HTML
      return html.html_safe
    end

    def disabled_item(options ={})
      html=<<-EOH
      <li class="#{options[:class]}">
      <a class="disabled"></a>
      </li>
      EOH
      return html.html_safe
    end
  end 

end
