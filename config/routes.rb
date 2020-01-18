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
  	resources :comments, only: [:create]
  	resources :jobs, only: [:index]
  	resources :engineers, only: [:new, :show, :edit, :create, :update, :destroy]
  	post   '/favorite/:info_id' => 'favorites#favorite',   as: 'favorite'
    delete '/favorite/:info_id' => 'favorites#unfavorite', as: 'unfavorite'
    post   '/follow/:engineer_id' => 'follows#follow',   as: 'follow'
    delete '/follow/:engineer_id' => 'follows#unfollow', as: 'unfollow'
    post   '/mark/:company_id' => 'marks#mark',   as: 'mark'
    delete '/mark/:company_id' => 'marks#unmark', as: 'unmark'
  end

  scope module: :companies do
  	resources :companies
  	resources :engineers, only: [:index]
  	resources :jobs, only: [:new, :show, :edit, :create, :update, :destroy]
  	resources :offers, only: [:new, :show, :create, :destroy]
  end

  namespace :admins do
  end

  root 'top#top'
  get 'top/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
