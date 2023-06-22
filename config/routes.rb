Rails.application.routes.draw do
  get 'bill/new'
  get 'cart', to: 'invoices#cart', as: 'cart'
  root 'pages#home'
  resources :users
  resources :categories
  resources :books
  resources :evaluaters
  resources :discounts
  resources :discount_details
  resources :book_discounts
  
  get '/create-book', to: 'books#new'
  post '/create-book', to: 'books#create'

  get '/create-evaluater/:id', to: 'evaluaters#new' ,as: "create_evaluaters"
  post '/create-evaluater', to: 'evaluaters#create'
  
  get '/books-destroy/:id', to: 'books#destroy', as: 'books_destroy'
  get '/books-edit/:id', to: 'books#edit', as: 'books_edit'
  
  get '/toggle_status/:id', to: 'categories#toggle_status', as: 'toggle_status'
  
  get '/toggle_status_book/:id', to: 'books#toggle_status_book', as: 'toggle_status_book'
  
  
  get '/create-categories', to: 'categories#new'
  post '/create-categories', to: 'categories#create'
  get '/category', to: 'categories#show'
  get '/category-destroy/:id', to: 'categories#destroy', as: 'category_destroy'
  get '/category-edit/:id', to: 'categories#edit', as: 'category_edit'

  
  get '/create-discounts', to: 'discounts#new'
  get '/create-discounts', to: 'discounts#create'
  get '/discount', to: 'discounts#show'
  get '/toggle_status_discount/:id', to: 'discounts#toggle_status', as: 'toggle_status_discount'
  get '/discount-destroy/:id', to: 'discounts#destroy', as: 'discount_destroy'
  get '/discount-edit/:id', to: 'discounts#edit', as:'discount_edit'
  

  get 'add-discount', to: 'discount_details#new'
  get 'add-discount', to: 'discount_details#create'
  get '/discount-detail-seen/:id', to: 'discount_details#edit', as:'discount_detail_seen'
  patch '/discount-detail/:id', to: 'discount_details#update'
  get '/discount-detail-destroy/:id', to: 'discount_details#destroy', as:'discount_detail_destroy'
  # post '/discount-detail-update', to: 'discount_details#update', as:'discount_detail_update'
  # login google
  get '/auth/:provider/callback', to: 'session#omniauth'
  #thống kê danh sách thuê
  get '/rental-history' , to: 'rentalhistorys#show', as:'rental_book_history'
  get '/toggle_status_history/:id', to: 'rentalhistorys#toggle_status', as: 'toggle_status_history'
  get '/history-detail/:id', to: 'rentalhistorys#show_detail', as:'history_detail'




  resources :invoices do
    collection do
      get 'add_to_cart/:book_id', action: 'add_to_cart', as: 'add_to_cart'
      post 'handle_quantity/:book_id', action: 'handle_quantity', as: 'handle_quantity'
    end
  end
  
  get '/remove_item/:book_id', to: 'invoices#remove_item', as: 'remove_item'

  post 'reduce_quantity', to: 'invoices#reduce_quantity', as: 'reduce_quantity'
  post 'add_quantity', to: 'invoices#add_quantity', as: 'add_quantity'
  get 'search_books', to: 'books#search', as: 'search_books'

  get '/revenue', to: 'invoices#revenue', as: 'revenue'


  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  get '/signup', to: 'users#new'
  get '/logout', to: 'session#destroy'
  get '/convert_status/:id', to: 'users#convert_status', as: 'convert_status'

  get '/detail/:id', to: 'pages#show', as: 'detail'
  get '/add_item/:id', to: 'pages#add_item', as: 'add_item'
  get '/cart', to: 'pages#cart'
end
