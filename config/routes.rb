Rails.application.routes.draw do
  devise_for :users
  root "datastores#index"

  resources :datastores do
  	resources :locations
  end

  resources :datafiles do
    resources :metadata
  end

  namespace :api do
		namespace :v1 do
			resources :datastores do
  			resources :locations
  		end
		end
	end

end
