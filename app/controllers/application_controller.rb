require 'sinatra'
require 'json'
require_relative 'models/bakery'
require_relative 'models/baked_good'

class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/bakeries' do
    bakeries = Bakery.all
    bakeries.to_json
  end

  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery_with_goods = {
      id: bakery.id,
      name: bakery.name,
      goods: bakery.baked_goods
    }
    bakery_with_goods.to_json
  end

  get '/baked_goods/by_price' do
    baked_goods = BakedGood.order(price: :desc)
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    most_expensive_good = BakedGood.order(price: :desc).first
    most_expensive_good.to_json
  end
  
end
