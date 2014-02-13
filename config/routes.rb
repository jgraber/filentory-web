Filentory::Application.routes.draw do
  devise_for :users
  root "datastores#index"

  resources :datastores do
  	resources :locations
  end
  resources :datafiles
end
