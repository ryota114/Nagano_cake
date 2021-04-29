class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8).reverse_order
  end 
  
  def show
  end 
  
end
