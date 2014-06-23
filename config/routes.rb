Rails.application.routes.draw do
  resources :friendships, as: 'friends'

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  root 'home#index'

  resources :pets do
    get :feed
    get :play
    patch :adopt
  end

  resources :users do
    resources :pets
    # resources :friendships, as: 'friends'
  end

  get "/about" => "home#about"
  get "/faq" => "home#faq"
  get "/contact" => "home#contact"

end
