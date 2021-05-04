class Public::OrdersController < ApplicationController
  def new 
    @order = Order.new
    @order.customer_id = current_customer.id
    @addresses = Address.all
  end 
  
  def comfirm
  end 
  
  def complete
  end 
  
  def create
  end 
  
  def index 
  end 
  
  def show
  end 
  
end
