Rails.application.routes.draw do

  resources :rabbits

  resources :birds

  resources :cats

  resources :dogs


  resources :pets

  devise_for :users

  resources :users do
    resources :pets
  end

  root 'home#index'

end
