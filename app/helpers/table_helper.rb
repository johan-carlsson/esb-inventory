module TableHelper
   def redpill_table(collection,options={}, &block)
    table = Table.new(self,options, collection)
    yield table
    return table.render_table.html_safe
  end

  def redpill_table_stylesheets
    <<-STYLES
    #{stylesheet_link_tag('redpill_table', :plugin => "redpill_table")}      
    #{stylesheet_link_tag('redpill_table_firefox', :plugin => "redpill_table") if request.env['HTTP_USER_AGENT'] =~ /firefox/i}
      <!--[if IE 7]>
    #{stylesheet_link_tag('redpill_table_msie7', :plugin => "redpill_table")}
      <![endif]-->
    STYLES
  end        

  class Table
    attr_accessor :options
    def initialize(actionview_base,options,collection)
      @base = actionview_base
      @collection = collection
      @options = options
      @table_name = @collection[0].class.table_name if collection.size > 0
      @column_defs = []
      @column_renderers = []
      @row_linker = lambda { |x| } #Initialize to empty proc
      @row_id = lambda { |x| } #Initialize to empty proc
    end

    def add_column(column_opts, &block)
      @column_defs << column_opts
      @column_renderers << lambda { |o, i| block.call(o) }
    end

    def add_column_with_index(column_opts, &block)
      @column_defs << column_opts
      @column_renderers << block
    end

    def row_linker(&block)
      @row_linker = block
    end

    def row_id(&block)
      @row_id = block
    end

    def row_class(&block)
      @row_class = block
    end

    def render_table
      table_str = start_table()
      @collection.each_with_index do |o, i|
        row_values = []
        @column_renderers.each { |r| row_values << r.call(o,i) }
        table_str += add_row(o, row_values)
      end
      return table_str + end_table()
    end

    private
    def add_row(row_object, *row_values)
      tr_opts = "onclick=\"window.location.href='#{@row_linker.call(row_object)}'\"" unless @row_linker.call(row_object).blank?
      row_class=@row_class && @row_class.call(row_object)
      row=<<-HTML
      <tr #{tr_opts} class="#{@base.cycle('even','odd')} #{row_class}" id="#{@row_id.call(row_object)}">
      <td>#{row_values.join("</td><td>")}</td>
      </tr>
      HTML
      return row.html_safe
    end

    def start_table
      table=<<-HTML
          <table class="redpill_table" width="100%" cellspacing="0" cellpadding="0" border="0">
          <thead>
            <tr>
      #{thead()}
            </tr>
          </thead>
          <tbody>
      HTML
      return table.html_safe 
    end

    def thead
      headers = ""
      @column_defs.each do |column_def|
        column_name = column_def.delete(:name).to_s
        order = (column_def[:order] && column_def.delete(:order)) || "#{@table_name}.#{column_name}"

        sortable= if column_def.has_key?(:sortable)
                    column_def[:sortable]
                  else
                    true
                  end

        #This if the collection is empty we are not able to get the tablename. Without it we can not sort and it does make sense to sort anyway
        if @collection.empty?
          sortable = false 
        end

        attrs = column_def.map { |key, value| %(#{key}="#{value}" ) }          
        if sortable && !options[:disable_sorting]
          headers += <<-HTML
              <th #{attrs.join(' ').to_s}#{sort_class(order)}>
                #{sort_link(column_name.humanize, order)}
              </th>
          HTML
        else
          headers += "<th #{attrs.to_s} class='unsortable'>#{column_name.humanize}</th>"
        end

      end
      return headers.html_safe
    end

    def end_table
      return "</tbody></table>".html_safe
    end      

    #Sets the class for table data depending on sort order.
    def sort_class(param)
      result = 'class="sortup"' if @base.params[:order] == param
      result = 'class="sortdown"' if @base.params[:order] == param + " desc"
      result ||= 'class="unsorted"'
      return result
    end

    #Returns remote link to sort by column
    def sort_link(text, param)
      key = param
      key += " desc" if @base.params[:order] == param
      options = {
        :url => {:params => @base.params.merge({:order => key, :page => nil})},
        :method => :get,
      }
      html_options = {
        :title => "Sort by %s" % text.downcase ,
        :href => @base.url_for(:method => :get ,:params => @base.params.merge({:order => key, :page => nil})),
        :onclick => "return false;"
      }
      return @base.link_to(text, options, html_options)+"<span class='sort'></span>".html_safe
    end

  end 

  
end
