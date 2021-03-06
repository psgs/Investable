Rails.application.routes.draw do
  devise_for :user, :controllers => {:sessions => 'sessions'}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => 'home#index'
  get '/stocks' => 'stocks#index', :as => 'user_root'
  get '/user' => 'user#show', :as => 'user'
  get '/search' => 'stocks#search', :as => 'search'
  get '/bitcoin' => 'bitcoin#index', :as => 'bitcoin'
  get '/comparison' => 'comparison#index', :as => 'comparison'
  get '/market' => 'market#index', :as => 'markets'

  controller :bitcoin do
    get 'bitcoin/bitfinex' => 'bitcoin#bitfinex', :as => 'bitfinex'
    get 'bitcoin/bitstamp' => 'bitcoin#bitstamp', :as => 'bitstamp'
    get 'bitcoin/btcchina' => 'bitcoin#btcchina', :as => 'btcchina'
    get 'bitcoin/okcoin' => 'bitcoin#okcoin', :as => 'okcoin'
  end

  resources :stocks, param: :symbol do
    member do
      post 'watch' => 'stocks#watch'
      post 'unwatch' => 'stocks#unwatch'
    end
  end

  if Rails.env.production?
    get '404', :to => 'application#not_found'
  end
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
  end
end
