Rails.application.routes.draw do
  get 'signup'  => 'users#new', as: :register
  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create', as: :login_create

  delete 'logout' => 'sessions#destroy', as: :logout
  get 'home' => 'users#index', as: :user_home
  get 'documents/get_file/:id' => 'documents#get_file'

  resources :users do
    resources :documents
  end
  root 'users#index'
end