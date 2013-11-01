require 'sinatra'
require 'json'

helpers do
  def set_origin
    response['Access-Control-Allow-Origin'] = 'http://localhost:9600'
  end
end

before do
  set_origin
end


get "/widgets" do
  pages = {}
  pages[1] = [{id: 1, name: 'Adam'}]
  pages[2] = [{id: 2, name: 'Ben'}]

  num = (params[:page] || 1).to_i

  res = {}
  res[:widgets] = pages[num]
  res[:meta] = {page: 1, total_pages: 2, unfiltered_total_pages: 2}
  res.to_json
end