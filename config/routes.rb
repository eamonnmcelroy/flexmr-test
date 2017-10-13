Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'welcome#index'

  resources :user_sessions, only: [:create, :destroy]
  resources :polls, only: [:index, :new, :create, :destroy] do
    resources :poll_responses, only: [:index, :new, :create]
  end

  get '/logout', to: 'user_sessions#destroy', as: :logout
  get '/login', to: 'user_sessions#new', as: :login
end
