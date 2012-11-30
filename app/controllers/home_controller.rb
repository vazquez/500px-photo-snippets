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
    photos = []
    @selected_ids.each do |id|
      photo = get_api("/photos/#{id}?image_size[]=3&image_size[]=4&image_size[]=5")['photo']
      images = {}
      photo['images'].each do |image|
        images[image['size']] = image['url']
      end
      photos << {:images => images, :id =>photo['id']}
    end
    
    @s = Snippet.create! :photos => photos, :username => session[:username]
    respond_to do |format|
      format.json do 
        render :json => {:success=>true, :url => "/s/#{@s._id}"}
      end
    end
  end
  def snippet
    oid = params[:id]
    @snippet = Snippet.find(oid)
    not_found if @snippet.blank?
  rescue
    not_found
  end
end
