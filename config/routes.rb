Rails.application.routes.draw do

  resources :pets

  devise_for :users

  resources :users do
    resources :pets

  end

  root 'home#index'

end
