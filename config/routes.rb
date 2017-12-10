Rails.application.routes.draw do


  root 'pages#home'

  devise_for :users,
             path: '',
             path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
             controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  resources :users, only: [:show] do
    member do
      post '/verify_phone_number' => 'users#verify_phone_number'
      patch '/update_phone_number' => 'users#update_phone_number'
    end
  end



  resources :foods, except: [:edit] do
    member do
      get 'listing'
      get 'pricing'
      get 'description'
      get 'photo_upload'
      get 'ingredients'
      get 'diets'
      get 'location'
      get 'preload'
      get 'preview'




    end
    resources :photos, only: [:create, :destroy]
    resources :orders, only: [:create]
    resources :calendars 


  end

  resources :foodie_reviews, only: [:create, :destroy]
  resources :chef_reviews, only: [:create, :destroy]


  get '/your_meals' => 'orders#your_meals'
  get '/your_orders' => 'orders#your_orders'

  post '/cart' => 'orders#cart'

  get '/my_cart' => 'orders#my_cart'
  get 'search' => 'pages#search'


  #------ Second level tutorial -----

  get 'dashboard' => 'dashboards#index'

  resources :orders, only: [:approve, :decline] do
    member do
      post '/approve' => "orders#approve"
      post '/decline' => "orders#decline"

    end
  end

  get '/host_calendar' => 'calendars#host'

end
