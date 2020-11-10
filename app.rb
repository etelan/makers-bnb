require 'sinatra/base'

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

  post '/login-query' do
    # Login verification goes here.
    
    redirect 'search'
  end 

  post '/signup-query' do 
    # Signup verification goes here.
    # Login verification goes here.

    redirect 'search'
  end

  get '/search' do 
    erb :search
  end

  run! if app_file == $0
end