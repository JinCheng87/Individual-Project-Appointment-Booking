Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  get '/admins', to: 'admins_home#index'
  root to:'home#index'

  resources :services
  get '/stores/:store_id/staffs/:id/appointments', to: 'appointments#staff_appointments', as: 'staff_appointments'
  resources :stores do
    resources :schedule
    resources :appointments
    resources :staffs
  end
end
