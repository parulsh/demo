Rails.application.routes.draw do


  root 'pages#home'

  devise_for :users,
             path: '',
             path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
             controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  resources :users, only: [:show]
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
      get 'portion_number'

  end






end
