require 'sinatra/base'
require_relative './lib/space.rb'
require_relative './lib/user_class.rb'

class MakersBnb < Sinatra::Base
  enable :sessions
  set :session_secret, 'Here be Dragons'

  # STAND IN VARIABLE FOR THE USER
  @@user = "adambaker"


  get '/' do
    erb :home
  end

  get '/login' do
    erb :login
  end

  get '/sign-up' do
    erb :signup
  end

  post '/login-query' do
    redirect '/error_page' if session[:user].nil?
    user = User.all.select {|user| user.username == params[:username]}
    session[:user] = user.shift
    session[:user].sign_in(username: params[:username],password: params[:password])
    # Login verification goes here.
    redirect 'search'
  end

  post '/signup-query' do
    session[:user] = User.create(username: params[:username],password: params[:password])
    session[:user].sign_in(username: params[:username],password: params[:password])
    # Signup verification goes here.
    # Login verification goes here.
    redirect 'search'
  end

  get '/search' do
    @places = Space.all
    erb :search
  end

  get '/listings' do
    p session[:user].username
    @places = Space.all
    erb :listings
  end

  get '/listings/new' do
    erb :new_listing
  end

  post '/listings/new' do

    p [:date]

    Space.create(name: params[:name],
      owner: session[:user].name,
      availability: Space.date_available?(params[:date]),
      description: params[:description],
      date: params[:date],
      price: params[:price])

    redirect '/listings'
  end

  post 'set-available' do

    redirect '/listings'
  end

  get '/error_page' do
    "ERROORRRR"
  end

  run! if app_file == $0
end
