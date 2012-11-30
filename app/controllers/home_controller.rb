class HomeController < ApplicationController
  def index
    redirect_to '/oauth/login' and return if session[:token].blank?
    consumer = OAuth::Consumer.new(AuthenticationController::CONSUMER_KEY, AuthenticationController::CONSUMER_SECRET, {:site=> AuthenticationController::BASE_URL})
    access_token = OAuth::AccessToken.new(consumer, session[:token], session[:secret])
    @fav_photos = JSON.parse(access_token.get('/photos?feature=popular&rpp=50&page=1&image_size=3&only=People').body)['photos']

    b = access_token.get('/users').body
    @user = JSON.parse(b)['user']
    puts @user.inspect
    
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
