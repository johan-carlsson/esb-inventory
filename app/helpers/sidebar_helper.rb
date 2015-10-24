module SidebarHelper
  def redpill_sidebar(&block)	
    "<div id='menu_container'><div id='menu'><ul>#{capture(Sidebar.new(self),&block)} </ul></div></div>".html_safe
  end

  def redpill_sidebar_stylesheets()
    <<-STYLES 
    #{stylesheet_link_tag "redpill_sidebar", :plugin => "redpill_sidebar"}
    STYLES
  end

  # determines if the given set of options contains the current controller
  def current_controller?(options)
    return true if current_page?(options) # trivial case
    if options.respond_to?(:has_key?) && options.has_key?(:controller)
      return options[:controller] == controller.controller_name
    end
    # try matching it - assumes it's a string url
    options =~ %r(/#{controller.controller_name})
  end

  class Sidebar   
    attr_reader :base        
    def initialize(actionview_base)
      @base = actionview_base
    end

    def item(name, url,options={},&block)
      SidebarItem.new(base,name, url,options).render(&block)
    end
  end

  class SidebarItem
    attr_reader :name,:base,:url,:options,:block

    def initialize(base,name, url,options={})
      @base=base
      @name=name
      @url=url
      @options= options
    end

    def sub_item(name, url,options={})
      if defined? Redpill::AccessControl
        return unless base.access_authorized_to_url?(url,{})
      end

      selected = options[:selected] 
      selected = base.current_controller?(url) unless options.include?(:selected)

      item=<<-EOS
        <li class="sub_item #{'selected' if selected}">
        <a href="#{url}">
        <span class="label">#{name}</span>
        </a>
        </li>
      EOS
      return item.html_safe
    end

    def render(&block)
      if defined? Redpill::AccessControl
        return unless base.access_authorized_to_url?(url,{})
      end

      image = options[:image] || "sidebar/#{name.gsub(/\s/,'_').downcase}.png"
      selected = options[:selected] 
      selected = base.current_controller?(url) unless options.include?(:selected)

      item=<<-EOS
        <li id="#{name.gsub(/\s/,'_').downcase}_sidebar_item" title="List #{name}" class="#{"selected" if selected}" onclick="location.href='#{url}';">
        <a href="#{url}">#{base.image_tag(image,:alt => '')}
        <span class="label">#{name}</span>
        </a>
        </li>
        EOS

        content=item
        if block_given?
          # base.concat(item,block.binding)
          # sub_item=%q(<span id="#{name.downcase}_sub_items" class="sub_items" style="#{'display:none' unless expanded}">)
          # puts "test #{block.name}" 
          # capture(&block)
          #  sub_item+="</span>"
          #  # if selected && !expanded
          #   base.concat( <<-EOS,block.binding)
          #   <script type="text/javascript" charset="utf-8">
          #   Event.observe(window, "load", function() {
          #     $j("##{name.downcase}_sub_items").slideDown("slow");
          #     });
          #     </script>
          #   EOS
          # end
          # end
          # else
          # #  return  item
        end
        return content.html_safe
    end

  end
end
