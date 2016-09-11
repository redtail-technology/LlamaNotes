Rails.application.routes.draw do
  devise_for :users
  devise_for :clients
  devise_for :companies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # authenticated :client do
  #   root 'clients/dashboard#show'
  # end

  # authenticated :company do
  #   root 'companies/dashboard#show'
  # end

  root 'dashboard#show'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  namespace 'api' do
    namespace 'v1' do
      match '*all' => 'base#cor', via: :options
      resources :notifications
      post 'webhooks/:token', to: 'webhooks#receive', as: 'webhooks'
      post 'authentication', to: 'authentication#create'
    end
  end

  namespace 'clients' do
    resource 'dashboard'
  end

  namespace 'companies' do
    resource 'dashboard'
  end

  post 'webhooks/:company_id', to: 'webhooks#create', as: 'webhooks'
  get 'webhooks/:token', to: 'webhooks#show'

  get 'session_portal', to: 'session#portal'

  get 'profile', to: 'profiles#show'
  post 'profile', to: 'profiles#update'
end
