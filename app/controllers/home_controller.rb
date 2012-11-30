class HomeController < ApplicationController
  before_filter :get_client

  def get_client
    return if session[:token].blank?
    consumer = OAuth::Consumer.new(AuthenticationController::CONSUMER_KEY, AuthenticationController::CONSUMER_SECRET, {:site=> AuthenticationController::BASE_URL})
    @client = OAuth::AccessToken.new(consumer, session[:token], session[:secret])
  end

  def get_api url
    JSON.parse(@client.get(url).body)
  end

  def index
    redirect_to '/oauth/login' and return if @client.nil?
    @fav_photos = get_api('/photos?feature=popular&rpp=50&page=1&image_size=3&only=People')['photos']
    @user = get_api('/users')['user']
    session[:username] = @user['username']
  end
  def photo_selected
    @selected_ids = params['data']

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
