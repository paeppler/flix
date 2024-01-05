Rails.application.routes.draw do
  resources :genres
  
  resources :users
  root "movies#index"
  
  resources :movies do
    resources :reviews
    resources :likes, only: [:create, :destroy]
  end

  get "movies/filter/:filter" => "movies#index", as: :filtered_movies

  resource :session, only: [:new, :create, :destroy]
  get "signup" => "users#new"

  # get "signin" => "sessions#new"
end
