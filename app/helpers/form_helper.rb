module FormHelper

  def redpill_form_builders_stylesheets
    return stylesheet_link_tag('redpill_tabular_form', :plugin => "redpill_form_builders")
  end

  def redpill_tabular_form_presenter(name, &proc)
    redpill_tabular_form(name, {:read_only => true}, &proc)
  end

  def redpill_tabular_form(record_or_name_or_array, options = {}, builder_options = {}, &proc)
    read_only = builder_options.delete(:read_only) || false
    remote = builder_options.delete(:remote) || false

    case record_or_name_or_array 
    when Array
      object = record_or_name_or_array.last
    else
      object = record_or_name_or_array
    end

    object_name = (options[:object_name] || ActionController::RecordIdentifier.singular_class_name(object))
    # default options
    html_options = options[:html] || {}
    html_options.reverse_merge!(:id => dom_id(object))
    if object.new_record?
      html_options.reverse_merge!(:class=> 'new')
    else
      html_options.reverse_merge!(:class=> 'edit')
    end
    options[:html] = html_options

    # #Check if the _erbout hack exists. The _erbout variable was removed in Rails 2.3
    if eval('defined?(_erbout)', proc.binding)
      _erbout = eval('_erbout', proc) #Needed for propagating the proper context to the form_for    
      _erbout = '' if read_only
    end

    if remote
      form_method = :remote_form_for
    else
      form_method = :form_for
    end
    # We have to use dup because form_for and url_for seems to modify its argument 
    url= (options[:url] || url_for(record_or_name_or_array))

    send form_method,record_or_name_or_array,(options||{}).merge(:builder => TabularFormBuilder) do |tabular_form|
      tabular_form.read_only = read_only
      tabular_form.remote = remote
      tabular_form.object = object
      tabular_form.url = url
      tabular_form.object_name = object_name
      tabular_form.record_or_name_or_array = record_or_name_or_array
      html=""
      html+=tabular_form.error_messages.to_s
      html+=tabular_form.begin_table
      html+=capture(tabular_form,&proc)
      html+=tabular_form.end_table
      html.html_safe
    end    
  end

  class TabularFormBuilder < ActionView::Helpers::FormBuilder
    attr_writer :number_of_columns
    attr_accessor :read_only,:remote,:cancel_path,:footer,:object,:record_or_name_or_array,:object_name,:url

    def self.define_field_method(method_name)
      alias_method "super_#{method_name}", method_name
      define_method(method_name) do |field, *args|

        options = args.extract_options!
        #To support tabing per column
        auto_index_offset=(@current_column+1)*100
        options[:tabindex] ||= @template.auto_index(auto_index_offset)

        # Sets the maxlength of the input field to the column limit value
        column = object.class.columns.find{|c| c.name == field.to_s}
        if column.respond_to?(:limit) && [:text_field, :text_area, :password_field].include?(method_name)
          options[:maxlength] ||= column.limit
          options[:size] ||=  30
        end

        args << options

        return add_column_pair(field.to_s.humanize+':'+mandatory(field).to_s, super(field, *args)) unless read_only
        return add_column_pair(field.to_s.humanize+':', self.object.send(field.to_s.sub(/_id$/, '')))
      end 
    end

    [:text_field, :text_area, :password_field, :check_box, :radio_button, :select,:date_select, :file_field].each { |input_type| define_field_method(input_type) }

    def belongs_to_auto_completer(association,method, options={}, tag_options={}, completion_options={})
      auto_index_offset=(@current_column+1)*100
      default_tag_options={:tabindex=> @template.auto_index(auto_index_offset),:size => 25,:class => "autocomplete"}
      default_completion_options = {:frequency => 0.5,:indicator => "#{association}_#{method}"}
      spinner= <<-HTML
        <span class="auto_complete_image">
          <span id="#{association}_#{method}" style="display:none;" class="auto_complete_spinner">
      #{@template.image_tag("/assets/redpill_form_builders/images/autocomplete-spinner.gif")}
          </span>
        </span>
      HTML
      add_column_pair(association.to_s.humanize+':'+mandatory(association).to_s, @template.belongs_to_auto_completer(object_name, association, method, options, default_tag_options.merge(tag_options), completion_options.merge(default_completion_options))+spinner)
    end

    def initialize(*args)
      super
      @current_column = 0
      @number_of_columns = 2
      @table_open = false
      @read_only = false
      @header_created = false
    end

    def begin_table(with_header_row=true)
      @table_open = true
      @current_column = 0
      ret_val = "<table class='redpill_tabular_form#{'_reader' if @read_only}' width='100%' border='0' cellspacing='0' cellpadding='0'>"
      ret_val += '<tr class="header">' if with_header_row
      return ret_val.html_safe
    end

    def end_table
      @table_open = false
      return '</tr></table>'.html_safe
    end

    def footer(footer_content)
      return form_content(footer_content)
    end

    def form_content(content)
      return_val = <<-HTML
      #{next_row}
          <td class="footer" colspan="#{@number_of_columns*2}">
      #{content}
          </td>
        </tr>
        <tr>
      HTML
      @current_column = 0
      return return_val.html_safe
    end

    def submit_and_cancel
      tags = submit_tag
      tags += cancel_tag
      return form_content(tags.html_safe)
    end

    def submit_and_cancel_buttons
      tags = submit_tag
      tags += cancel_button_tag
      return form_content(tags.html_safe)
    end

    def submit_tag
      @template.submit_tag("Save", {:class=> "controller_button",:tabindex => 500, :accesskey => 'S', :title=>"#{@template.shortcut_modifier}-s",:class => "save"})
    end

    def cancel_tag
      if remote
        @template.link_to_remote('Cancel', {:url => url, :method => :get,:tabindex => 501, :accesskey => 'Z', :title=>"#{@template.shortcut_modifier}-z",:class => "cancel"})
      else
        @template.link_to('Cancel', url, :tabindex => 501, :accesskey => 'Z', :title=>"#{@template.shortcut_modifier}-z",:class => "cancel")
      end
    end

    def cancel_button_tag
      if remote
        @template.button_to_remote('Cancel', {:url => url, :method => :get,:tabindex => 501, :accesskey => 'Z', :title=>"#{@template.shortcut_modifier}-z",:class => "cancel"})
      else
        @template.button_to('Cancel', '', :tabindex => 501, :accesskey => 'Z', :title=>"#{@template.shortcut_modifier}-z",:class => "cancel",:onclick => "window.location = \"#{url}\";return false")
      end
    end



    def number_of_columns=(cols)
      @number_of_columns = cols
    end

    def add_column_pair(column1, column2, column1_tag='th', column2_tag='td')
      begin_table unless @table_open

      tags = ''

      unless @header_created
        tags += <<-HTML 
            <td colspan="#{@number_of_columns*2}">&nbsp;</td>
          </tr>
          <tr>
        HTML
        @header_created = true
      end

      @current_column += 1
      old_current = @current_column
      @current_column %= @number_of_columns
      tags += @template.content_tag(column1_tag, column1) + @template.content_tag(column2_tag, column2)
      tags += new_row if @current_column == 0
      tags.html_safe
    end

    def empty_column
      return add_column_pair('&nbsp;'.html_safe, '&nbsp;'.html_safe)
    end

    def empty
      @current_column += 1
      @current_column %= @number_of_columns
      close_row
    end


    def next_row()
      missing_cols = @current_column % @number_of_columns
      tags = ''
      missing_cols.times do
        tags += empty_column()
      end
      return tags.html_safe
    end

    def error_messages
      # (@template.error_messages_for(object_name)) || ''
      #  <% if @niss.errors.any? %>
    # <div id="error_explanation">
    #   <h2><%= pluralize(@niss.errors.count, "error") %> prohibited this niss from being saved:</h2>

    #   <ul>
    #   <% @niss.errors.full_messages.each do |msg| %>
    #     <li><%= msg %></li>
    #   <% end %>
    #   </ul>
    # </div>
  # <% end %>
      html=''
      if object.errors.any?
        error_messages=object.errors.full_messages.map do |msg|
          @template.content_tag(:li,msg)
        end.join.html_safe

        html=@template.content_tag(:div,:id => "errorExplanation") do
            @template.content_tag(:h2,"#{@template.pluralize(object.errors.count, 'error')} prohibited this #{object_name} from being saved") +
            @template.content_tag(:p) +
            @template.content_tag(:ul,error_messages)
        end
      end
      return html
      

    end

    private
    def mandatory(field)
      # The regular expression /^#{c.to_s}(_id)?$/ is used so <field> matches <field>_id but not <field>_whatever
      # validates_presence_of_columns = (object.class.read_inheritable_attribute(:validates_presence_of_columns)  || [])
      # mandatory = "*" if validates_presence_of_columns.find{|c| /^#{c.to_s}(_id)?$/ =~ field.to_s} 
    end

    def new_row
      close_row() + "<tr>\n".html_safe
    end

    def close_row
      "</tr>\n".html_safe
    end
  end

end
