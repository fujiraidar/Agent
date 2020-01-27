Rails.application.routes.draw do

  devise_for :admins
  devise_for :companies
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  scope module: :users do
  	resources :infos
  	resources :drafts
    resources :users
  	resources :helps
  	resources :comments, only: [:create]
  	resources :engineers, only: [:new, :show, :edit, :create, :update, :destroy]
  	post   '/favorite/:info_id' => 'favorites#favorite',   as: 'favorite'
    delete '/favorite/:info_id' => 'favorites#unfavorite', as: 'unfavorite'
    post   '/follow/:engineer_id' => 'follows#follow',   as: 'follow'
    delete '/follow/:engineer_id' => 'follows#unfollow', as: 'unfollow'
    post   '/mark/:company_id' => 'marks#mark',   as: 'mark'
    delete '/mark/:company_id' => 'marks#unmark', as: 'unmark'
    resources :rooms
    get '/ranking' => 'infos#ranking', as: 'ranking'
    get '/withdraw/:id' => 'users#withdraw', as: 'withdraw'
    resources :boxes, only: [:show, :create, :destroy]
    resources :interviews, only: [:create, :destroy]
  end

  scope module: :companies do
  	resources :companies do
  		resources :company_payments, only: [:new, :create]
  	end
  	resources :engineers, only: [:index]
  	resources :jobs
  	resources :topics
  	resources :offers, only: [:new, :show, :create, :destroy]
  end

  namespace :admins do
  	resources :admins, only: [:index]
  	resources :users, only: [:index, :update, :destroy]
  	resources :engineers, only: [:index, :update, :destroy]
  	resources :companies, only: [:index, :update, :destroy]
  	resources :company_payments, only: [:index, :destroy]
  end

  namespace :api, format: 'json' do
    get 'infos/preview'
  end

  root 'top#top'
  get 'top/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
