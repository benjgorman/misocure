class AlbumsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destory
  
  def index
    @title = "All Albums" 
    @albums = Album.search(params[:search])
  end
  
  def create
     @artist = Artist.find(params[:artist_id])
     @album = @artist.albums.build(params[:album])
     
    if @album.save
      flash[:success] = "Album created!"
      redirect_to @album
    else
      @title = "Add an Album"
      render 'new'
    end
  end
  
  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash[:success] = "Album destroyed."
    redirect_back_or albums_path
  end
  
   def new
     @artist = Artist.find(params[:artist_id])
    @album = @artist.albums.build
    @title = "album Sign Up"
  end
  
  def show
    @album = Album.find(params[:id])
    @songs = @album.songs.paginate(:page => params[:page])
    @title = @album.name
  end
  
  private
  
  def authorized_user
      @album = Albums.find(params[:id])
      redirect_to album_url unless current_user?(@album.artist.user)
    end
  
end