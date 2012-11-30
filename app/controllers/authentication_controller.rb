require 'oauth'
class AuthenticationController < ApplicationController
	CONSUMER_KEY = 'HNF9wZddjSvtaDa4CZ1Yxf4Vs1lQCF7Ll3B313aO'
  CONSUMER_SECRET = 'DFnGdWD0mtO4SexCejBjdVmmSEgJ9rLRugAM2KUS'
  BASE_URL = 'https://api.500px.com/v1'

	def oauth_login
		consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, {:site=> BASE_URL})
  	request_token = consumer.get_request_token
  	redirect_to request_token.authorize_url 
	end

	def oauth_callback
		consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET, {:site=> BASE_URL})
    request_token = consumer.get_request_token
    oauth_verifier = params['oauth_verifier']
    redirect_to :controller=>'home', :action=>'index', :oauth_verifier=>oauth_verifier
	end
end
