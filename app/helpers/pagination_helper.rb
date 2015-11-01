module PaginationHelper
  PAGE_SIZE=100
  def self.pages(collection,params)
     pages=Pages.new(collection,params)    
     pages
  end

  class Pages
    def initialize(collection,params)
      @params=params
      @current_page=(params[:page] || 1).to_i
      @collection=collection
      @pages=collection.each_slice(PAGE_SIZE).to_a
    end

    def per_page
      PAGE_SIZE
    end

    def current_page
      (@pages[@current_page-1] || [])
    end

    def empty?
      @pages.empty?
    end

    def current_page_number
      @current_page
    end

    def next_page_number
      if (@pages.length > @current_page)
        @current_page+1
      end
    end
    
    def previous_page_number
      if (@current_page != 1 && @pages.length <= @current_page)
        @current_page-1
      end
    end

    def total_entries
      @collection.count
    end
  end
end
