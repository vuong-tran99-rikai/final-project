Rails.application.routes.draw do
  root 'pages#home'
  namespace :admin do
    resources :categories do
      member do
        patch :toggle_status
      end
    end
    resources :discounts  do
      resources :discount_details, only: [:edit]
    end
    resources :discount_details
    resources :books do
      member do
        patch :toggle_status
      end
      # collection do
      #   get :search_book
      # end
    end
    resources :evaluaters, only: [:index]
    resources :rentalhistorys do
      member do
        patch :toggle_status
      end
    end
    resources :users, only: [:index, :destroy] do
      member do
        patch :convert_status
      end
    end
  end
  resources :users
  resources :book_discounts
  
  resources :evaluaters, only: [:show, :create]

  resources :pages do
    collection do
      get :category
    end
  end

  resources :invoices do
    collection do
      get :cart
      get :remove_item
      post :reduce_quantity
      post :add_quantity
      get :revenue
      get 'add_to_cart/:book_id', action: 'add_to_cart', as: 'add_to_cart'
      # get :add_to_cart
      post 'handle_quantity/:book_id', action: 'handle_quantity', as: 'handle_quantity'
    end
    # collection do
    #   post 'handle_quantity/:book_id', action: 'handle_quantity', as: 'handle_quantity'
    # end
    # member do
    #   get :add_to_cart
    # end
  end
  

  # login google
  get '/auth/:provider/callback', to: 'session#omniauth'
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  get '/signup', to: 'users#new'
  get '/logout', to: 'session#destroy'
  
end
