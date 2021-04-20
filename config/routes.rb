Rails.application.routes.draw do
  # adminとcustomerのdeviseを作成,アクションがかぶるので下記設定で整えた
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
  }
  
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }
  
  # namespaceを使用、pubilcのURLにはpublicを表示したくないので、scope modul:で実装
  scope modul: :public do
    root to: "public/homes#top"
    get "/about" => "public/homes#about"
    # get "/items" => "public/items#index"
    resources :items, only: [ :index,:show ], module: :public
    resources :customers, only: [ :show, :edit, :update ], module: :public
    resources :cart_items, only: [ :index, :update ], module: :public
  end 
  
  # namespaceを使用、adminのURLにはadminを表示するので、namespaceで実装
  namespace :admin do
    root to: "homes#top"
    resources :items, only: [ :index, :new, :create, :show, :edit, :update ]
    resources :customers, only: [ :index, :show, :edit, :update ]
    resources :orders, only: [ :show, :update ]
    resources :genres, only: [ :index, :create, :edit, :update ]
    resources :order_details, only: [:update]
  end 
end
