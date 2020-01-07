Rails.application.routes.draw do
  devise_for :admins
  devise_for :companies
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  scope module: :users do
    resources :users do
  	  resources :helps
  	  resources :engineers do
  		  resources :infos, only: [:new, :show, :create, :edit, :update, :destroy]
  	  end
    end
    resources :infos, only: [:index]
  end

  scope module: :companies do
  	resources :companies
  end

  namespace :owners do
  end

  root 'top#top'
  get 'top/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
