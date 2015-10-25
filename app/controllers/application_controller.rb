class ApplicationController < ActionController::Base
  protect_from_forgery
  VALID_SORT_KEYS=["id","identifier","name","client_id","service_id","starts_at","group","service","client","class","system","on_name","contact","phone","email"]
  VALID_NUMERIC_SORT_KEYS=["service_count","client_count","provide_count"]

  def sort(collection,order)
    key=order.split(" ").first
    direction=order.split(" ").last
    # We only sort by know keys for security reasons because we use send()
    if VALID_NUMERIC_SORT_KEYS.include?(key)
    sorted=collection.sort_by{|o| o.send(key).to_i}
    elsif VALID_SORT_KEYS.include?(key)
    sorted=collection.sort_by{|o| o.send(key).to_s.downcase}
    else
      return collection
    end
    if direction=="desc"
      sorted.reverse!
    end
    sorted

  end
end

