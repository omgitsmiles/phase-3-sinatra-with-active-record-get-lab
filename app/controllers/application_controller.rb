class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
 
  get '/bakeries' do
  bakeries = Bakery.all
  bakeries.to_json
  end

  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    baked = BakedGood.all.sort{ |a,b| b.price <=> a.price }
    baked.to_json
  end

  get '/baked_goods/most_expensive' do
    expensive = BakedGood.order(:price).last 
    # maximum = BakedGood.pluck(:price).max()
    # expensive = BakedGood.where("price == #{maximum}", maximum) returns the both of the most expensive baked good
    # expensive = BakedGood.find_by(params[:price]) passes test, not right answer
    expensive.to_json
  end

end
