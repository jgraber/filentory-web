Filentory::Application.routes.draw do
  devise_for :users
  root "datastores#index"

  resources :datastores do
  	resources :locations
  end

  resources :datafiles

  namespace :api do
		namespace :v1 do
			resources :datastores do
  			resources :locations
  		end
		end
	end

end
