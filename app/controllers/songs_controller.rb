class SongsController < ApplicationController
  
  def index
    @title = "All Songs" 
    @songs = Song.paginate(:page => params[:page])
  end
  
  def destroy
    @song.destroy
    flash[:success] = "Song destroyed."
    redirect_back_or root_path
  end
  
  def create
     @album = Album.find(params[:artist_id])
     @song = @album.songs.build(params[:song])
     
    if @song.save
      flash[:success] = "Song created!"
      redirect_to root_path
    else
      flash.now[:message] = @song.errors.first 
      render 'pages/home'
    end
  end
  
  def new
    @album = Album.find(params[:album_id])
    @song = @album.songs.build
    @title = "album Sign Up"
  end
  
  def show    
    @song = Song.find(params[:id])
    @title = @song.name
  end
  
end
  