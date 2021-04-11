Rails.application.routes.draw do
  # namespaceを使用、pubilcのURLにはpublicを表示したくないので、scope modul:で実装
  scope modul: :public do
    root to: "public/homes#top"
    get "/about" => "public/homes#about"
  end 
  
  # namespaceを使用、adminのURLにはadminを表示するので、scopeで実装
  scope :admin do
    root to: "admin/homes#top"
    
  end 
end
