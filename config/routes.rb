Gormify::Application.routes.draw do
  get "payments/express"
  get "songs/download"
  #resources :payments, :new => {:express => :get}
  resources :payments

  get "sessions/new"
  get "users/basket"

  resources :users
  
  resources :orders
  
  resources :line_items
  resources :sessions, :only => [:new, :create, :destroy]
  
  resources :artists do
    resources :albums
  end
  
  resources :albums do
    resources :songs
  end
  
  
  resources :songs do
    get :download
  end
  
  match "/orders/:id", :to => "orders#show", :as => "/cart"
  
  match "/verify/:id", :to => "users#verify"
  
  match "/cart", :to => "users#basket", :as => "/cart"
  
  match '/basket', :to => 'orders#basket'
  
  match '/purchases', :to => 'orders#purchases'
      
  #artists
  match '/newartist', :to => 'artists#new'
  match '/manage', :to => 'artists#manage'
  
  #users
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  
  match '/contact', :to => 'pages#contact'
  match '/terms', :to => 'pages#terms'
  match '/privacy', :to => 'pages#privacy'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'
  root :to => 'pages#home'
 

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
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
