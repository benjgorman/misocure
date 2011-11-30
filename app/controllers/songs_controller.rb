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
  
  def download
    @orders = current_user.orders.find_all_by_status(1)
    
    #@orders = @orders.find_all_by_song(:song_id)
    #@song = Song.find(params[:song_id])
    found = false
    
    @orders.each do |order|
      if order.line_items.find_by_song_id(params[:song_id])
       found = true
      end
    end
    
    if found == true
      @song = Song.find(params[:song_id])
      redirect_to(@song.authenticated_url(params[:style]))
    else
      render :action => "fail"
    end
  end
    
  
  def create
     @album = Album.find(params[:album_id])
     @song = @album.songs.build(params[:song])
     @song.price = 0.79
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
    @song = Song.find_by_id(params[:id])
    if @song.nil?
      render :action => "notfound"
    else
    @title = @song.name
    end
  end
  
end
  