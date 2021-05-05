class Public::OrdersController < ApplicationController
  def new 
    @order = Order.new
    @order.customer_id = current_customer.id
    @addresses = Address.where(customer_id: current_customer.id)
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
    elsif params[:select_address] == "1"
      # 選択した住所が空白の場合とそれ以外
      # params[:order][:address]の[:order]はnew.htmlのform_withが@orderに依存しているので
      # [:order]のパラメータの一部としてaddress_idが返っているので定義する必要がある
      if params[:order][:address_id].blank?
        @order = Order.new
        @order.customer_id = current_customer.id
        @addresses = Address.all
        flash[:error] = "住所が選ばれていません"
        render :new
      else
        @address = current_customer.addresses.find(params[:order][:address_id])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
      end 
    elsif params[:select_address] == "2"
      # 新しいお届け先の情報に空欄がある場合と全ての項目が埋められている場合
      if @order.postal_code.blank? || @order.address.blank? || @order.name.blank?
        @order = Order.new
        @order.customer_id = current_customer.id
        @addresses = Address.all
        flash[:error] = "空欄があります"
        render :new
      else
        @address = Address.new(address_params)
        @address.customer_id = current_customer.id
        @address.name = @order.name
        @address.postal_code = @order.postal_code
        @address.address = @order.address
        @address.save
      end 
    end
  end
  
  def complete
  end 
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    cart_items = CartItem.where(customer_id: current_customer.id)
    # 注文した商品をそれぞれcart_itemsからorder_detailsへ保存させる。cart_itemsは後ほど削除する。
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new(order_detail_params)
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = @order.id
      order_detail.price = (cart_item.item.price * 1.1).floor
      order_detail.amount = cart_item.amount
      order_detail.save
    end 
    cart_items.destroy_all
    redirect_to complete_orders_path
  end 
  
  def index 
    @orders = Order.where(customer_id: current_customer.id)
  end 
  
  def show
    @order = Order.find(params[:id])
  end 
  
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, 
                                  :name, :shipping_cost, :total_payment, 
                                  :payment_method)
  end
  
  def order_detail_params
    params.permit(:item_id, :order_id, :price, :amount, :making_status)
  end 
  
  def address_params
    params.permit(:name, :postal_code, :address)
  end
end
