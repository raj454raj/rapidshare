Rails.application.routes.draw do
  get 'documents/index'
  get 'documents/new'
  get 'documents/create'
  get 'documents/destroy'

  devise_for :users
  resources :users do
    resources :documents
  end
  get 'documents/get_file/:id' => 'documents#get_file'

  root to: "users#index", as: :user_home
end
