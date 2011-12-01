class SongsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destory
  
  def index
    @title = "Browse users" 
    @songs = Song.search(params[:search])
  end
  
  def destroy
    @song.destroy
    flash[:success] = "Song destroyed."
    redirect_back_or root_path
  end
  
  def download
    @orders = current_user.orders.find_all_by_status(1)
    
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
      redirect_to @album
    else
      @title = "Add a Song"
      render 'new'
    end
  end
  
  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:success] = "Song destroyed."
    redirect_back_or songs_path
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
  private
  
  def authorized_user
      @song = Song.find(params[:id])
      redirect_to song_url unless current_user?(@song.album.artist.user)
  end
  
end
  