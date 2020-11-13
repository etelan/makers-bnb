require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/space.rb'
require_relative './lib/user_class.rb'

class MakersBnb < Sinatra::Base
  enable :sessions
  set :session_secret, 'Here be Dragons'
  register Sinatra::Flash


  get '/' do
    session.clear
    erb :home
  end

  get '/login' do
    erb :login
  end

  get '/sign-up' do
    erb :signup
  end

  post '/login-query' do
     @user = User.sign_in(username: params[:username],password: params[:password])

    if @user
      @user
      session[:user_id] = @user.id
      redirect '/search'
    else flash[:notice] = 'Please check your username or password.'
    redirect('/login')
    end
  end

  post '/signup-query' do
    User.create(username: params[:username],password: params[:password])
    @user = User.sign_in(username: params[:username],password: params[:password])
    session[:user_id] = @user.id
    redirect '/search'
  end

  get '/search' do
    @user = User.find(session[:user_id])
    @places = Space.all
    erb :search
  end

  get '/listings' do
    @user = User.find(session[:user_id])
    @places = Space.all
    erb :listings
  end

  get '/request' do
    @user = User.find(session[:user_id])
    @place = Space.find(params[:id])
    erb :request_form
  end

  get '/listings/new' do
    erb :new_listing
  end

  post '/listings/new' do

    p [:date]
    @user = User.find(session[:user_id])
    Space.create(name: params[:name],
      owner: @user.username,
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
