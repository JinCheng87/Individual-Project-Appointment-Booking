Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  get '/admins', to: 'admins_home#index'
  root to:'home#index'

  resources :services
  get '/stores/:store_id/staffs/:id/appointments', to: 'appointments#staff_appointments', as: 'staff_appointments'
  get '/stores/:store_id/shedule/:id',to:'schedule#show', as: 'store_schedule'
  resources :stores, except: [:new, :create, :destroy] do
    resources :appointments
    resources :staffs
  end
end
