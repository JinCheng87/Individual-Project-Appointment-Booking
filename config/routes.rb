Rails.application.routes.draw do
  devise_for :admins, controllers: { registrations: 'admins/registrations'}
  devise_for :clients, controllers: { registrations: 'clients/registrations' }
  root to:'home#index'
end
