require 'oauth'
require 'json'
class HomeController < ApplicationController
  def index
  	# @fav_photos = params[:oauth_verifier]
  	redirect_to '/oauth/login' if params[:oauth_verifier].blank?
  	consumer = OAuth::Consumer.new(AuthenticationController::CONSUMER_KEY, AuthenticationController::CONSUMER_SECRET, {:site=> AuthenticationController::BASE_URL})
  	access_token = OAuth::AccessToken.new(consumer, params[:oauth_verifier])
  	@fav_photos = JSON.parse(access_token.get('/photos?feature=popular&rpp=50&page=1&image_size=3&only=People').body)['photos']
  end
  def photo_selected
  	@selected_ids = params['data']
  	p @selected_ids.inspect
  	respond_to do |format|
  		format.json do 
  			render :json=>{:success=>true}
  		end
  	end
  end
  def show_snippet

  end
end
