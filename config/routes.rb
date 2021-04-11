Rails.application.routes.draw do
  # adminとcustomerのdeviseを作成
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
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
  end 
  
  # namespaceを使用、adminのURLにはadminを表示するので、namespaceで実装
  namespace :admin do
    root to: "homes#top"
    
  end 
end
