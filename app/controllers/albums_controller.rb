class AlbumsController < ApplicationController
  
  def index
    @title = "All Albums" 
    @albums = Album.search(params[:search])
   #@albums = Album.paginate(:page => params[:page])
  end
  
  def create
     @artist = Artist.find(params[:artist_id])
     @album = @artist.albums.build(params[:album])
     
    if @album.save
      flash[:success] = "Album created!"
      redirect_to root_path
    else
      flash.now[:message] = @album.errors.first 
      render 'pages/home'
    end
  end
  
  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash[:success] = "Album destroyed."
    redirect_back_or root_path
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
  
end