class ApplicationController < ActionController::Base
  protect_from_forgery
  VALID_SORT_KEYS=["id","identifier","name","client_id","integration_id","starts_at","ends_at","group","integration","client","class","system","on_name","contact","phone","email"]
  VALID_NUMERIC_SORT_KEYS=["integration_count","client_count","provide_count"]


  def filter_and_sort(collection,keys,params)
    filtered=filter(collection,keys,params[:search_for])
    sort(filtered,keys,params[:order])
  end

  def sort(collection,valid_keys,order)
    key=order.split(" ").first
    direction=order.split(" ").last
    # We only sort by know keys for security reasons because we use send()
    if valid_keys.include?(key) && numeric_key?(key)
      sorted=collection.sort_by{|o| o.send(key).to_i}
    elsif valid_keys.include?(key)
      sorted=collection.sort_by{|o| o.send(key).to_s.downcase}
    else
      return collection
    end
    if direction=="desc"
      sorted.reverse!
    end
    sorted
  end


  def filter(collection,keys,filter)
    if filter.blank?
      return collection
    end
    terms=filter.split(" ")

    keys=filter_keys(keys,collection)
    numeric_keys=numeric_keys(keys,collection)

    collection.find_all do |i|
      values=keys.map {|k| i.send(k)}
      numeric_values=numeric_keys.map {|k| i.send(k)}
      terms.all? do |term| 
        if numeric_operator?(term)
          numeric_values.find do |value|
            value.send(numeric_operator(term),numeric_value(term))
          end
        else
          values.find do |value|
            puts "term #{term}"
            puts "value #{value}"
            value.to_s =~/#{term.to_s}/i
          end
        end
      end
    end
  end

  def numeric_operator?(term)
    term.to_s =~ /^[=<>]+\d/
  end

  def numeric_value(term)
    term=term.to_s.match(/\d+/)[0].to_i
  end

  def numeric_operator(term)  
    operator=term.match(/<=|>=|>|</).to_s
    if(operator.blank?)
      "=="
    else
      operator
    end
  end

  def filter_keys(keys,collection)
    collection.first.methods.map(&:to_s).find_all{|m| keys.include? m}
  end

  def numeric_keys(keys,collection)
    filter_keys(keys,collection).find_all{|k| k =~ /count$/}
  end

  def numeric_key?(key)
    key =~ /count$/
  end

end

