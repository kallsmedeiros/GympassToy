Rails.application.routes.draw do
  root 'home#index' 

  get 'home/index'

  get 'login/index'

  get 'login/index_do'

  resources :locations
  resources :gyms
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match ':controller(/:action(/:id))', :via => [:get, :post]
end
