class LineItemsController < ApplicationController
  before_filter :authenticate
  def create
    @order = current_user.orders.find_by_status(0)
    
    if !@order
      @order = current_user.orders.new
      @order.status = 0
      @order.total = 0.00
      @order.save
    end
    
    song = Song.find(params[:song_id])
    @line_item = @order.line_items.build(song: song)
    
    @order.total = @order.total + @line_item.song.price
    @order.save
    
    if @line_item.save
     flash[:success] = "Item created!"
     redirect_to basket_path
    else
     flash[:message] = "Whoops"
     redirect_to songs_path
    end
  end
  
  def destroy
    @order = current_user.orders.find_by_status(0)
    @line_item = @order.line_items.find_by_id(params[:id])
    @order.total = @order.total - @line_item.song.price
    @order.save
    #@line_item = Line_Item.find(params[:id])
    @line_item.destroy
    
    flash[:success] = "I deleted that song btw!"
    
    redirect_to songs_path
  end
end