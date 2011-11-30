class PaymentsController < ApplicationController
  
   def express
    @order = current_user.orders.find_by_status(0)
    response = EXPRESS_GATEWAY.setup_purchase(@order.total,
      :ip                => request.remote_ip,
      :return_url        => new_payment_url,
      :cancel_return_url => songs_url
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
  
  def new
    @payment = Payment.new(:express_token => params[:token])
  end
  
  def create
    @order = current_user.orders.find_by_status(0)
    #@payment = @order.payment.new(params[:payment])
    @payment = @order.build_payment(params[:payment])
    @payment.ip_address = request.remote_ip
    if @payment.save
      if @payment.purchase
        render :action => "success"
        #set download stuff here
      else
        render :action => "failure"
      end
      
    else
      render :action => 'new'
    end
  end
end