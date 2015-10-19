class ApplicationController < ActionController::Base
  protect_from_forgery
  VALID_SORT_KEYS=["id","name","consumer_id","service_id","starts_at","group","service","consumer"]

  def sort(collection,order)
    key=order.split(" ").first
    # We only sort by know keys for security reasons because we use send()
    unless VALID_SORT_KEYS.include? key
      return collection
    end
    direction=order.split(" ").last
    sorted=collection.sort_by{|o| o.send(key).to_s.downcase}
    if direction=="desc"
      sorted.reverse!
    end
    sorted

  end
end

