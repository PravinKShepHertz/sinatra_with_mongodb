require 'sinatra'
require 'mongoid'
require 'json'

configure do
  Mongoid.configure do |config|
    # config.sessions = {
    #   :default => {
    #   :hosts => ["localhost:27017"], :database => "my_db"
    # }

    config.sessions = {
      :default => {
      :hosts => ["10.0.2.12:24745"], :database => "demo_db", :username => 'zv0xjtzn7ape1ujw', :password => 'yvjg5mosk93hv2uemsp3h0epajjzvmft'
    }

  }
  end
end

class User
  include Mongoid::Document
  
  field :name, type: String
  field :email, type: String
  field :desc, type: String
end

helpers do
  def link_to(url,text=url,opts={})
    attributes = ""
	opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
	"<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end

  def delete_user_button(user_id)
    erb :_delete_user_button, locals: { user_id: user_id}
  end
end

# Get all of our routes
get '/' do
  @users = User.all
  erb :'users/index'
end

# Get the New User form
get '/new' do
  @user = User.new
  erb :'users/new'
end

post '/user' do
  User.create(:name => params[:name], :email => params[:email], :desc => params[:desc])
  @users = User.all
  erb :'users/index'
end

# Deletes the user with this ID and redirects to homepage.
delete "/user/:id" do
  @user = User.find(params[:id]).destroy
  redirect "/"
end
