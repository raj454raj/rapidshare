Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resources :documents
  end
  get 'documents/get_file/:id' => 'documents#get_file'
  root to: "users#index", as: :user_home
end
