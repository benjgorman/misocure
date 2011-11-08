class ArtistsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destory
  
  def index
    @title = "All Artists" 
    @artists = Artist.paginate(:page => params[:page])
  end
  
  def manage
    @user = @current_user
    @title = "Artist Manager"
    @artists = @user.artists.paginate(:page => params[:page])
  end
  
  def create
    @artist = current_user.artists.new(params[:artist])
    
    if @artist.save
      flash[:success] = "Artist created!"
      redirect_to root_path
    else
      flash.now[:message] = @artist.errors.first 
      render 'pages/home'
    end
  end
  
  def destroy
    @artist.destroy
    flash[:success] = "Artist destroyed."
    redirect_back_or root_path
  end
  
  def new
    @artist = Artist.new
    @title = "Band Sign Up"
  end
  
  def show
    @artist = Artist.find(params[:id])
    @albums = @artist.albums.paginate(:page => params[:page])
    @title = @artist.name
  end
  
  private
    def authorized_user
      @artist = Artist.find(params[:id])
      redirect_to root_path unless current_user?(@artist.user)
    end
  
end