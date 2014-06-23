Rails.application.routes.draw do
  resources :friendships

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  root 'home#index'

  resources :pets do
    get :feed
    get :play
    patch :adopt
  end

  resources :users do
    resources :pets
    resources :friendships
  end

  get "/about" => "home#about"
  get "/faq" => "home#faq"
  get "/contact" => "home#contact"

end
