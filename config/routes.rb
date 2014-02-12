Filentory::Application.routes.draw do
  devise_for :users
  root "datastores#index"

  resources :datastores
  resources :datafiles
end
