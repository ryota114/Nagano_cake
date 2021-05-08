class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    # whereメソッドで現在のカスタマーのcart_itemをもってくる
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @sum = 0
  end 
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_update_params)
    redirect_to cart_items_path
  end 
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end 
  
  def destroy_all
    # whereメソッドで現在のカスタマーのcart_itemをもってくる
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.destroy_all
    redirect_to cart_items_path
  end 
  
  def create
    # items/show.htmlで:amountを受け取るのでnew時点でストロングパラメータで受け取る
    @cart_item = CartItem.new(cart_item_create_params)
    @cart_item.customer_id = current_customer.id
    
    # 既にカートに商品を登録している場合、個数の更新のみおこなう。
    # 商品が未登録の場合は、そのまま登録を行う。
    if CartItem.exists?(customer_id: @cart_item.customer_id, item_id: @cart_item.item_id)
      @old_cart_item = CartItem.where(customer_id: current_customer.id, item_id: @cart_item.item_id)
      @old_cart_item.update(amount: @cart_item.amount)
    else
      @cart_item.save
    end 
    redirect_to cart_items_path
  end 
  
  
  private
  
  # updateはrequireがなければ値が更新されない
  # createはrequireがあるとエラーになる
  def cart_item_update_params
    params.require(:cart_item).permit(:item_id,:amount)
  end 
  def cart_item_create_params
    params.permit(:item_id,:amount)
  end 
  
end
