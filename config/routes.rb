Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  root to:'home#index'

  get '/admin', to: 'admin#index'
  get '/users/appointments', to: 'appointments#customer_appointments', as:'customer_appointments'
  get '/stores/:store_id/staffs/:id/appointments', to: 'appointments#staff_appointments', as: 'staff_appointments'
  get 'admin/stores/:store_id/schedule/:id', to:'admin#show_calendars', as: 'store_schedule'
  get 'admin/employees', to:'admin#show_employees',as: 'show_empolyees'
  get 'admin/appointments', to:'admin#show_appointments', as: 'show_appointments'
  get 'admin/stores', to:'admin#show_stores', as: 'show_stores'
  get 'admin/services', to:'admin#show_services', as: 'show_services'
  resources :services
  resources :stores, except: [:new, :create, :destroy, :index] do
    resources :appointments, except: [:index]
    resources :staffs
  end

  get '*unmatched_route', to: 'application#not_found'
end
