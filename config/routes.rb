Gallery::Application.routes.draw do
  devise_for :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  namespace :admin do
    root :to => 'home#index'

    resources :news, :except => [:show]
    resources :pictures, :except => [:show, :create, :new]
    resources :pictures_collections, :only => [:create, :new]
    resources :categories, :except => [:show] do
      resources :pictures, :only => [:index] do
        collection do
          put :update_positions
        end
      end
      collection do
        put :update_positions
      end
    end

    resources :pages do
      collection do
        put :update_positions
      end
    end
  end

  resources :news, :only => [] do
    resources :pictures, :only => [:show]
  end

  resources :categories, :only => [:show] do
    resources :pictures, :only => [:index]
  end

  resources :pages, :only => [:show]

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'news#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
