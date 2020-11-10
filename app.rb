require 'sinatra/base'
require_relative './lib/space.rb'
require_relative './lib/user_class.rb'

class MakersBnb < Sinatra::Base
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

  get '/new-listing' do
    erb :new_listing
  end

  run! if app_file == $0
end
