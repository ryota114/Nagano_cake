class Admin::OrderDetailsController < ApplicationController
  def update
    # viewで更新を押すと該当のidが返されるので、OrerDetailのidを読み取り変数に入れる
    # redirect先はorderdetail（各注文商品）の大本である注文ページを指定
    @order_details = OrderDetail.find(params[:id])
    @order_details.update(order_detail_params)
    redirect_to admin_order_path(@order_details.order_id)
  end
  
  
  # updateアクションでmaking_statusの変更を受け付けるために実装
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end 
end
