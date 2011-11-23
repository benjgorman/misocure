class OrdersController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destory
  
  def index
   
  end
  
  def basket
    @user = @current_user
    @title = "Basket"
    @order = current_user.orders.find_by_status(0)
    
     if !@order
      @order = current_user.orders.new
      @order.status = 0
      @order.total = 0.00
      @order.save
    end
  end
  
  def create
    @order = current_user.orders.new(params[:order])
    @order.status = 0
    @order.total = 0.00
    if @order.save
      flash[:success] = "Artist created!"
      redirect_to root_path
    else
      flash.now[:message] = @order.errors.first 
      render 'pages/home'
    end
  end
  
  def destroy
    @order = current_user.orders.find_by_status(0)
    @order.destroy
    
    flash[:success] = "Your Cart is now emepty. Better get shopping buddy!"
    
    redirect_to songs_path
   
  end
  
  def new
    
  end
  
  def show
    @order = Order.find(params[:id])  
  end
  
  private
    def authorized_user
      
    end
  
end