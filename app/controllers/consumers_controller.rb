class ConsumersController < ApplicationController
  # GET /consumers
  # GET /consumers.json
  def index
    @show_csv_export_button=true
    params[:order] ||= 'name'
    @consumers = sort(Consumer.all,params[:order])

    respond_to do |format|
      format.html # index.html.erb
      format.csv # index.csv.rb
      format.json { render json: @consumers }
    end
  end

  # GET /consumers/1
  # GET /consumers/1.json
  def show
    @consumer = Consumer.find_by_id(params[:id])

    respond_to do |format|
      format.html { redirect_to subscriptions_consumer_url(@consumer) }
      format.json { render json: @consumer }
    end
  end

  # GET /consumers/1/subscriptions
  # GET /consumers/1/subscriptions.json
  def subscriptions
    params[:order] ||= 'service'
    @consumer = Consumer.find_by_id(params[:id])
    @subscriptions= sort(@consumer.subscriptions,params[:order])

    respond_to do |format|
      format.html
      format.json { render json: @subscriptions }
    end
  end

end
