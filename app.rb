require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/space.rb'
require_relative './lib/user_class.rb'

class MakersBnb < Sinatra::Base
  register Sinatra::Flash
  enable :sessions
  set :session_secret, 'Here be Dragons'


  # before do
  #   @user = User.instance
  # end

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
    # redirect '/error_page' if session[:user].nil?
     @user = User.sign_in(username: params[:username],password: params[:password])

    if @user
      @user
      session[:user_id] = @user.id
      p session[:user_id]
      redirect 'search'
    else flash[:notice] = 'Please check your username or password.'
    redirect('/login')
    end
    # session[:user].sign_in(username: params[:username],password: params[:password])
    # Login verification goes here.
  end

  post '/signup-query' do
    User.create(username: params[:username],password: params[:password])
    @user = User.sign_in(username: params[:username],password: params[:password])
    session[:user_id] = @user.id
    redirect 'search'
  end

  get '/search' do
    p session[:user_id]
    @user = User.find(session[:user_id])
    @places = Space.all
    erb :search
  end

  get '/listings' do
    p "Hello"
    p session[:user_id]
    p @user = User.find(session[:user_id])
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
