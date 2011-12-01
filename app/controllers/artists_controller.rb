class ArtistsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destory
  
  def index
    @title = "Browse Artists" 
    @artists = Artist.search(params[:search])
  end
  
  def manage
    @user = @current_user
    @title = "Artist Manager"
    
    @artists = @user.artists.paginate(:page => params[:page])
    
    if @artists.size == 0
      render :action => "empty"
    end
  end
  
  def edit
    @title = "Edit artist"
    @artist = Artist.find(params[:id])
  end
  
  def create
    @artist = current_user.artists.new(params[:artist])
    
    if @artist.save
      flash[:success] = "Artist created!"
      redirect_to @artist
    else
      @title = "Artist"
      render 'new'
    end
  end
  
  def update
    @artist = Artist.find(params[:id])
    if @artist.update_attributes(params[:artist])
      flash[:success] = "Artist Updated"
      redirect_to @artist
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:success] = "Artist destroyed."
    redirect_back_or artists_path
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
      redirect_to artist_url unless current_user?(@artist.user)
    end
  
end