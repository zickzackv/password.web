PasswordWeb::Application.routes.draw do
  resources :groups do
    resources :members do
      member do
        get 'accept' => 'members#accept', as: 'accept'
        put 'accept' => 'members#accepted'
      end
    end
    resources :secret_records
  end

  authenticated :user do
    root :to => 'groups#index'
  end
  root to: 'home#index'
  devise_for :users
  resources :users
end
