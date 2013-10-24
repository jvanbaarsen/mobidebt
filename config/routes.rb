Mobidebt::Application.routes.draw do

  root 'sessions#new'

  resources :users do
    collection do
      get 'purchase/:type' => 'users#purchase', as: 'purchase'
    end
  end
  get 'balance' => 'users#edit', as: 'edit_balance'
  get 'sign_up' => 'users#new'
  post 'sign_up' => 'users#create'
  get 'dashboard' => 'users#show'

  resource :sessions
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
end
