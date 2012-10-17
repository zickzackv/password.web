PasswordWeb::Application.routes.draw do
  resources :secret_records

  authenticated :user do
    root :to => 'secret_records#index'
  end
  root to: 'home#index'
  devise_for :users
  resources :users
end
