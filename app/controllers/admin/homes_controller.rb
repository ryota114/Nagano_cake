class Admin::HomesController < ApplicationController
  def top
    
    # 遷移元の内容を取得
    path = Rails.application.routes.recognize_path(request.referer)
    
    # ヘッダーからアクセスした場合
    if params[:is_from_header] == "1"
      @orders = Order.page(params[:page]).reverse_order
      
    # それ以外（カスタマー詳細画面から遷移や戻る操作）
    else
      # カスタマー詳細画面からの遷移を分岐、pathのコントローラーとアクションで認識
      if path[:controller] == "admin/customers" && path[:action] == "show"
        @customer = Customer.find(params[:customer_id])
        @orders = @customer.orders.page(params[:page]).reverse_order
      
      # 戻る操作などによるエラー対策
      else
        @orders = Order.page(params[:page]).reverse_order
      end 
    end 
  end 
end
