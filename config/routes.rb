Rails.application.routes.draw do
  # adminとcustomerのdeviseを作成,アクションがかぶるので下記設定で整えた
  devise_for :admin, :skip => [:registrations, :password],
                      controllers: {sessions: 'admin/sessions'}
  
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }
  
  # namespaceを使用、pubilcのURLにはpublicを表示したくないので、scope modul:で実装
  scope modul: :public do
    root to: "public/homes#top"
    get "/about" => "public/homes#about"
    get "/customers/my_page" => "public/customers#show", as: "my_page"
    # get "/items" => "public/items#index"
    resources :items, only: [ :index,:show ], module: :public
    resources :addresses, only: [ :index, :create, :edit, :update, :destroy ], module: :public
    
    resources :customers, only: [ :edit, :update ], module: :public do
      # resourcesを使用したコントローラーにルートを追加する方法の１つ、collectionを使用
      collection do
        get "unsubscribe"
        patch "withdraw"
      end 
    end 
    
    resources :orders, only: [ :new, :create, :index, :show ], module: :public do
      # resourcesを使用したコントローラーにルートを追加する方法の１つ、collectionを使用
      collection do
        post "confirm"
        get "complete"
      end 
    end 
    
    resources :cart_items, only: [ :index, :update, :create, :destroy ], module: :public do
      # resourcesを使用したコントローラーにルートを追加する方法の１つ、collectionを使用
      collection do
        delete "destroy_all"
      end 
    end 
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
