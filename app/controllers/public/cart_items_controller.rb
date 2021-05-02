class Public::CartItemsController < ApplicationController
  def index
    # whereメソッドで現在のカスタマーのcart_itemをもってくる
    @cart_items = CartItem.where(customer_id: current_customer.id)
    
  end 
  
  def update
    @cart_item = CartItem.find(params[:id])
    pp @cart_item
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end 
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end 
  
  def destroy_all
  end 
  
  def create
    # items/show.htmlで:amountを受け取るのでnew時点でストロングパラメータで受け取る
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
  end 
  
  
  private
  
  def cart_item_params
    params.permit(:item_id,:amount)
  end 
  
end
