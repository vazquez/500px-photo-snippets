class HomeController < ApplicationController
  def index
    redirect_to '/oauth/login' and return if session[:token].blank?
    consumer = OAuth::Consumer.new(AuthenticationController::CONSUMER_KEY, AuthenticationController::CONSUMER_SECRET, {:site=> AuthenticationController::BASE_URL})
    access_token = OAuth::AccessToken.new(consumer, session[:token], session[:secret])
    @fav_photos = JSON.parse(access_token.get('/photos?feature=popular&rpp=50&page=1&image_size=3&only=People').body)['photos']

    @user = JSON.parse(access_token.get('/users').body)['user']
    session[:username] = @user['username']
  end
  def photo_selected
    @selected_ids = params['data']
    p @selected_ids.inspect

    @s = Snippet.create! :photos => @selected_ids, :username => session[:username]
    
    respond_to do |format|
      format.json do 
        render :json=>{:success=>true, :url => "/s/#{@s._id}"}
      end
    end
  end
  def snippet
    oid = params[:id]
    @snippet = Snippet.find(oid)
    
  end
end
