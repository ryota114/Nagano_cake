class Address < ApplicationRecord
  belongs_to:customer
  
  # public/orders/new.htmlでカラムをつなげた表示をするためにmodelで定義する
  def use_address
    "〒" + self.postal_code + self.address + self.name
  end 
  
end
