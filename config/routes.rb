Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions: 'users/sessions'
  }
  devise_for :companies
  devise_for :users

  scope module: :users do
  	resources :infos
  	resources :drafts, only: [:index, :edit, :update, :destroy]
    resources :users, only: [:show, :index, :update, :destroy]
  	resources :helps
  	resources :comments, only: [:create]
  	resources :engineers, only: [:new, :show, :edit, :create, :update]
  	post   '/favorite/:info_id' => 'favorites#favorite',   as: 'favorite'
    delete '/favorite/:info_id' => 'favorites#unfavorite', as: 'unfavorite'
    post   '/follow/:engineer_id' => 'follows#follow',   as: 'follow'
    delete '/follow/:engineer_id' => 'follows#unfollow', as: 'unfollow'
    post   '/mark/:company_id' => 'marks#mark',   as: 'mark'
    delete '/mark/:company_id' => 'marks#unmark', as: 'unmark'
    resources :rooms, only: [:show, :create]
    get '/ranking' => 'infos#ranking', as: 'ranking'
    get '/withdraw/:id' => 'users#withdraw', as: 'withdraw'
    patch '/evolution/:id' => 'engineers#evolution', as: 'evolution'
    resources :boxes, only: [:show, :create, :destroy]
    resources :interviews, only: [:create, :destroy]
    get 'infos/tags/:tag', to: 'infos#index', as: :info_tag
    get 'helps/tags/:tag', to: 'helps#index', as: :help_tag
  end

  scope module: :companies do
  	resources :companies do
  		resources :company_payments, only: [:new, :create]
  	end
  	resources :engineers, only: [:index]
  	resources :jobs
  	resources :topics
  	resources :offers, only: [:new, :show, :create, :destroy]
  	get 'topics/tags/:tag', to: 'topics#index', as: :topic_tag
  	get 'jobs/tags/:tag', to: 'jobs#index', as: :job_tag
  end

  namespace :admins do
  	resources :admins, only: [:index, :show, :destroy]
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
  get '/contact' => 'top#contact', as: 'contact'
  post '/contacting' => 'top#contacting', as: 'contacting'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
