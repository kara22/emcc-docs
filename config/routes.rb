Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"
  devise_for :users
  root to: 'pages#home'
  get "/team" => "pages#team"
  get "/documents_category" => "pages#documents_category"
  get "/travels_site" => "pages#travels_site"


  resources  :documents

  resources :travels

  put "/travels/:id/valide" => "travels#valide", :as => "valide_travel"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
