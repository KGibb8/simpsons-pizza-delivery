require './config/environment'
require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'erb'

set :views, './views'
use Rack::Session::Cookie, expire_after: 2592000,
  secret: "335b3c91f14c2504dd2086229c92d2f4fb3c7bd8e0ad045f20cd20860be3dc6be52a823382daf4ff39c1353d6cff4bb1da42f3c2cdfd9a05dddbbb1cf2166604"

def current_user
  User.find_by(id: session[:user_id])
end

##########################################################

get '/login' do
  @roles = Role.all.order(:name)
  erb :session_new, :layout => :main
end

# Actually do the login
post '/login' do
  @user = User.find_by(username: params[:username])
  @user = @user.authenticate(params[:password])
  if @user
    session[:user_id] = @user.id.to_s
    redirect to('/users')
  else
    redirect to('/login')
  end
end

post '/sign_up' do
  @user = User.create(params[:user])
  @user.roles << Role.find_by(name: "Customer")
  session[:user_id] = @user.id.to_s
  redirect to('/users')
end

##########################################################

get '/users' do
  @user = User.new()
  @users = User.all.order(:name)
  @roles = Role.all.order(:name)
  @orders = Order.all.order(:order_date)
  erb :users, :layout => :main
end

post '/users' do
  @user = User.create(params[:user])
  # ActiveRecord can save related M:M stuff
  # when the params has something like:
  #  "role_ids" => ["4","6","2"]
  # which comes together by having a checkbo set up like
  # <input type="checkbox" value="%<= role.id %>" name="role_ids[]"><
  redirect to('/users')
end

get "/users/:id/edit" do
  @orders = Order.all.order(:order_date)
  @user = User.find(params[:id])
  @roles = Role.all.order(:name)
  erb :users, :layout => :main
end

post "/users/:id" do
  binding.pry
  user = User.find(params[:id])
  user.update(params[:user])
  redirect to("/users")
end

##########################################################

get '/roles' do
  @roles = Role.all.order(:name)
  erb :roles_index, :layout => :main
end

get '/roles/:id/edit' do
  @role = Role.find(params[:id])
  @users = User.all.order(:name)
  erb :roles_edit, :layout => :main
end

post "/roles/:id" do
  role = Role.find(params[:id])
  role.update(params[:role])
  redirect to("/roles")
end


##########################################################

get '/customer_form' do
  erb :customer_form, :layout => :main
end

post '/customer_form' do
  # params user_id
end

##########################################################

get '/place_order' do
  @order = Order.new
  erb :orders, :layout => :main
end

post '/order' do
  params[:order_date] = Time.now
  current_user.orders << Order.create(params)
  redirect to('/users')
end

get '/ordered' do
  erb :ordered, :layout => :main
end

##########################################################

post '/logout' do
  session[:user_id] = nil
  redirect to('/login')
end

#

#
# post '/logout' do
#   current_user = nil
#   redirect to('/login')
# end
#
# get '/login' do
#   @users = User.all.order(:name)
#   erb :session_new, :layout => :main
# end
#
# post '/login' do
#   @user = User.find_by(id: params[:user_id])
#   @user = @driver.authenticate(params[:password])
#   if @user
#     session[:user_id] = @user.id.to_s
#     redirect to('/my_orders')
#   else
#     redirect to('/login')
#   end
# end
#
# post '/sign_up' do
#   unless params[:can_beer].nil?
#     @user = User.create(name: params[:name], can_beer: params[:can_beer], password: params[:password])
#   else
#     @user = User.create(name: params[:name], password: params[:password])
#   end
#   session[:user_id] = @user.id.to_s
#   redirect to('/my_orders')
# end
#
# get '/my_orders' do
#   if current_user.can_beer
#     @available_orders = Order.where(is_beer: true, is_delivered: false)
#   else
#     @available_orders = Order.where(is_beer: false, is_delivered: false)
#   end
#   erb :orders, :layout => :main
# end
#
# post '/select_order' do
#   @order = Order.find_by(id: params[:order_id])
#   # current_user.update(orders: @order)
#   current_user.orders << @order
#   redirect to('/driver_confirmation')
# end
#
# post '/back_to_my_orders' do
#   redirect to ('/my_orders')
# end
#
# get '/driver_confirmation' do
#   erb :confirmation, :layout => :main
# end
#
# post '/order_delivered' do
#   @order = current_user.orders.find_by(id: params[:order_id])
#   @order.is_delivered = true
#   current_user.orders.find_by(id: params[:order_id]).destroy
#   redirect to ('/my_orders')
# end
#
# # @order = Order.create(is_beer: true, address: "123 Fake Street")
# # driver.orders.create(address: params[:address], can_beer: params[:can_beer])
#

after do
  ActiveRecord::Base.connection.close
end
