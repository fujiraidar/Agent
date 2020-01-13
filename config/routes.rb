Rails.application.routes.draw do
  devise_for :admins
  devise_for :companies
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  scope module: :users do
  	resources :infos
    resources :users
  	resources :helps
  	resources :engineers, only: [:new, :show, :create, :edit, :update, :destroy]
  	post   '/favorite/:info_id' => 'favorites#favorite',   as: 'favorite'
    delete '/favorite/:info_id' => 'favorites#unfavorite', as: 'unfavorite'
  end

  scope module: :companies do
  	resources :companies
  	resources :engineers, only: [:index]
  	resources :jobs
  	resources :offers
  end

  namespace :admins do
  end

  root 'top#top'
  get 'top/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
