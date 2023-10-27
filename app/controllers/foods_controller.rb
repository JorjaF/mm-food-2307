class FoodsController < ApplicationController
  def index
    api_key = '2100ua40X5SOT1GSMGc1XTCXwh5XjIVDuSNfPS6p'
    query = "sweet potatoes"
  
    api_url = "https://api.nal.usda.gov/fdc/v1/foods/search?query=#{URI.encode_www_form_component(query)}"
  
    conn = Faraday.new(url: api_url) do |faraday|
      faraday.headers['X-API-KEY'] = api_key
    end
  
    response = conn.get
  
    if response.success?
      data = JSON.parse(response.body, symbolize_names: true)
      @total_results = data[:totalHits]
      @foods = data[:foods].first(10)
  
    else
      flash[:error] = "Failed to fetch data from the Food Data Central API"
    end
    render json: { total_results: @total_results, foods: @foods }
  end
end
