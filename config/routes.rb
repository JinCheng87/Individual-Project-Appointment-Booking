Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  get '/admins', to: 'admins_home#index'
  root to:'home#index'

  resources :services

  resources :stores do
    resources :appointments
    resources :staffs
  end
end
