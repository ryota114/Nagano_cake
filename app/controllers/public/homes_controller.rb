class Public::HomesController < ApplicationController
  def top
    # itemテーブルからcreated_at降順（新しい順）に４件
    @items = Item.limit(4).order("created_at DESC")
  end 
  
  def about
  end 
end
