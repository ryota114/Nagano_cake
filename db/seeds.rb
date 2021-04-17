# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  Admin.create!(
    email: "test@test.com",
    password: "testtest"
  )
  
  Customer.create!(
    last_name: "太郎",
    first_name: "山田",
    last_name_kana: "タロウ",
    first_name_kana: "ヤマダ",
    email: "tarou@gmail.com",
    password: "tarotaro",
    postal_code: "5550000",
    address: "大阪府高槻市",
    telephone_number: "00000000001",
    is_deleted: "false"
  )
  
  Customer.create!(
    last_name: "栄螺",
    first_name: "磯野",
    last_name_kana: "サザエ",
    first_name_kana: "磯野",
    email: "sazae@gmail.com",
    password: "sazasaza",
    postal_code: "6740000",
    address: "兵庫県明石市",
    telephone_number: "00000000002",
    is_deleted: "false"
  )
  
  6.times do |num|
  Order.create!(
    customer_id: "1",
    postal_code: "5550001",
    address: "配送先住所山田",
    name: "配送先氏名山田",
    shipping_cost: 1 + num,
    total_payment: 10 + num,
    payment_method: rand(0..1),
    status: rand(0..4)
  )
  end
  
  6.times do |num|
  Order.create!(
    customer_id: "2",
    postal_code: "6740001",
    address: "配送先住所磯野",
    name: "配送先氏名磯野",
    shipping_cost: 100 + num,
    total_payment: 1000 + num,
    payment_method: 0,
    status: 2
  )
  end
  
  Genre.create!(
      name: "ケーキ類"
  )
  
  Genre.create!(
      name: "パン類"
  )
  
  Item.create!(
      genre_id: "1",
      name: "ケーキ",
      image_id: "1",
      introduction: "商品説明",
      price: "450",
      is_active: "true"
  )
  
  Item.create!(
      genre_id: "2",
      name: "パン",
      image_id: "2",
      introduction: "商品説明",
      price: "50",
      is_active: "true"
  )
    
  6.times do |num|
  OrderDetail.create!(
    item_id: "1",
    order_id: num + 1,
    price: 50 + num,
    amount: 1 + num,
    making_status: 0
  )
  
  OrderDetail.create!(
    item_id: "2",
    order_id: num + 1,
    price: 150 + num,
    amount: 1 + num,
    making_status: 0
  )
  end 
  
  6.times do |num|
  OrderDetail.create!(
    item_id: "1",
    order_id: num + 7,
    price: 250 + num,
    amount: 10 + num,
    making_status: 0
  )
  
  OrderDetail.create!(
    item_id: "2",
    order_id: num + 7,
    price: 350 + num,
    amount: 1 + num,
    making_status: 0
  )
  end