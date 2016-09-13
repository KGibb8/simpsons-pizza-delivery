require './config/environment'
require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'erb'

set :views, './views'
use Rack::Session::Cookie, expire_after: 2592000,
  secret: "335b3c91f14c2504dd2086229c92d2f4fb3c7bd8e0ad045f20cd20860be3dc6be52a823382daf4ff39c1353d6cff4bb1da42f3c2cdfd9a05dddbbb1cf2166604"

def current_user
  Driver.find_by(id: session[:driver_id])
end

post '/logout' do
  current_user = nil
  redirect to('/login')
end

get '/login' do
  @drivers = Driver.all.order(:name)
  erb :session_new, :layout => :main
end

post '/login' do
  binding.pry
  @driver = Driver.find_by(id: params[:driver_id])
  @driver = @driver.authenticate(params[:password])
  if @driver
    session[:driver_id] = @driver.id.to_s
    redirect to('/my_orders')
  else
    redirect to('/login')
  end
end

post '/sign_up' do
  unless params[:can_beer].nil?
    Driver.create(name: params[:name], can_beer: params[:can_beer], password: params[:password])
  else
    Driver.create(name: params[:name], password: params[:password])
  end
  redirect to('/my_orders')
end

get '/my_orders' do
  if current_user.can_beer
    @available_orders = Order.where(is_beer: true, is_delivered: false)
  else
    @available_orders = Order.where(is_beer: false, is_delivered: false)
  end
  erb :orders, :layout => :main
end

post '/select_order' do
  @order = Order.find_by(id: params[:order_id])
  current_user.orders << @order
  redirect to('/driver_confirmation')
end

post '/back_to_my_orders' do
  redirect to ('/my_orders')
end

get '/driver_confirmation' do
  erb :confirmation, :layout => :main
end

post '/order_delivered' do
  @order = current_user.orders.find_by(id: params[:order_id])
  @order.is_delivered = true
  current_user.orders.find_by(id: params[:order_id]).destroy
  redirect to ('/my_orders')
end

# @order = Order.create(is_beer: true, address: "123 Fake Street")
# driver.orders.create(address: params[:address], can_beer: params[:can_beer])


after do
  ActiveRecord::Base.connection.close
end
