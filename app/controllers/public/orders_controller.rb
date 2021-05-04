class Public::OrdersController < ApplicationController
  def new 
    @order = Order.new
    @order.customer_id = current_customer.id
    @addresses = Address.all
  end
  
  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    @order.total_payment = 0
    @order.total_payment += 800
    
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.each do |cart_item|
      item_price = (cart_item.item.price * cart_item.amount * 1.1).floor
      @order.total_payment += item_price
    end
    
    if params[:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    else
      
    end
  end
  
  def complete
  end 
  
  def create
  end 
  
  def index 
  end 
  
  def show
  end 
  
  
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
  
end
