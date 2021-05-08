class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @order = Order.find(params[:id])
    # OrderモデルとOrderDetailsはhas_manyとbelongs_toの関係
    @order_details = @order.order_details
  end 
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(params[:id])
  end 
  
  private
  
  # updateアクションでstatusの変更を受け付けるために実装
  def order_params
    params.require(:order).permit(:status)
  end 
end
