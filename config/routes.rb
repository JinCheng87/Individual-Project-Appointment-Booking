Rails.application.routes.draw do
  # devise_for :admins, controllers: { sessions: 'admins/sessions',registrations: 'admins/registrations'}
  # devise_for :clients, controllers: { sessions: 'clients/sessions',registrations: 'clients/registrations' }
  get '/admins', to: 'admins_home#index'
  root to:'home#index'

  resources :services

  resources :stores do
    resources :staffs
  end
end
