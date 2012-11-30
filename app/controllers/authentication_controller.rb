class AuthenticationController < ApplicationController
  CONSUMER_KEY = 'HNF9wZddjSvtaDa4CZ1Yxf4Vs1lQCF7Ll3B313aO'
  CONSUMER_SECRET = 'DFnGdWD0mtO4SexCejBjdVmmSEgJ9rLRugAM2KUS'
  BASE_URL = 'https://api.500px.com/v1'

  def index
  end
  
  def login
    consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, {:site=> BASE_URL})
    request_token = consumer.get_request_token
    #redirect_to request_token.authorize_url
    access_token = consumer.get_access_token(request_token, {}, { :x_auth_mode => 'client_auth', :x_auth_username => params[:username], :x_auth_password => params[:password] })
    
    session[:token] = access_token.token
    session[:secret] = access_token.secret
    redirect_to :controller=>'home', :action=>'index'
  rescue
    puts 'didnt work'

    flash[:notice] = "Wrong"
    redirect_to '/oauth/login'
    
  end
  
  
end
