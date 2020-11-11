require 'sinatra/base'
require_relative './lib/space.rb'
require_relative './lib/user_class.rb'

class MakersBnb < Sinatra::Base

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

  get '/login-query' do
    @@lampost = User.sign_in(username: params[:username],password: params[:password])
    # Login verification goes here.
    p @@lampost
    redirect 'search'
  end

  post '/signup-query' do
    # Signup verification goes here.
    # Login verification goes here.

    redirect 'search'
  end

  get '/search' do
    p @@lampost
    @places = Space.all
    erb :search
  end

  get '/listings' do

    # STAND IN VARIABLE FOR THE USER
    @user = "adambaker"
    @places = Space.all
    erb :listings
  end

  get '/listings/new' do
    erb :new_listing
  end

  post '/listings/new' do

    p [:date]

    Space.create(name: params[:name], 
      owner: @@user, 
      availability: Space.date_available?(params[:date]), 
      description: params[:description], 
      date: params[:date], 
      price: params[:price])

    redirect '/listings'
  end

  post 'set-available' do
    
    redirect '/listings'
  end

  run! if app_file == $0
end
