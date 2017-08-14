require 'rails_helper'
require 'database_cleaner'

RSpec.describe ServicesController, type: :controller do
  render_views

  let(:store) { Store.create!( name: "company name", location: "418 7th Ave Brooklyn", hours: '10AM-10PM', description: "An Exclusive SPA, ", phone_number: '1234567890' ) }
  let(:service_params) { { name: 'collagen Mask', duration: '30', price: '30',description: 'Hydrating, brightening and firm the skin.', category: 'special treatment' } }
  let(:service_params_2) { { name: 'massage', duration: '60', price: '90',description: 'Hydrating, brightening and firm the skin.', category: 'special treatment' } }

  let(:service_invalid_params) { {name: nil, duration: '', price: nil,description: 'Hydrating, brightening and firm the skin.', category: 'special treatment'} }

  let(:user_admin){
    User.create!(name: 'admin', email: 'admin@gmail.com', password: '123456', phone_number: '6469155917')
  }
  let(:user_customer){
    user_customer = User.create!(name: 'Mike', email: 'mike@gmail.com', password: '123456', phone_number: 987654321)
  }

  describe 'GET #index' do

    it 'shows no services when it is empty' do
      get :index 

      expect(response.body).to include('No service yet')
    end

    it 'list all the services' do
      service = Service.create!(service_params)
      service2 = Service.create!(service_params_2)

      get :index

      expect(Service.count).to eq(2)
      expect(response.body).to include("#{service.name}")
      expect(response.body).to include("#{service2.name}")
      expect(response.body).to include('price')
      expect(response.body).to include("#{service.duration}")
      expect(response.body).to include('<table')
    end
  end

  describe 'GET #new' do
    it 'ask for login when not sign in' do
      get :new

      expect(response.code).to eq('302')
      expect(response.body).to include('sign_in')
    end

    it 'shows an error when is not admin' do
      sign_in(user_customer)

      get :new

      expect(response.body).not_to include('Create a service')
    end

    it 'render a form when admin login' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      get :new

      expect(response.body).to include('<form')
      expect(response.body).to include('Create a service')
    end
  end

  describe 'GET show' do
    it 'render a 404 for non-existent service' do
      get :show, params: {id: -1}

      expect(response.body).to include("The page you were looking for doesn't exist")
    end

    it 'render details of individule service' do
      service = Service.create!(service_params)

      get :show, params: {id: service.id}

      expect(response.body).to include('service detail')
      expect(response.body).to include('price')
      expect(response.body).to include('description')
    end
  end

  describe 'GET edit' do
    let(:service) {service = Service.create!(service_params)}
    it 'ask for login when not sign in' do
      get :edit, params: {id: service.id}

      expect(response.code).to eq('302')
      expect(response.body).to include('sign_in')
    end

    it 'shows an error when is not admin' do
      sign_in(user_customer)

      get :edit, params: {id: service.id}

      expect(response.body).not_to include('Create a service')
    end

    it 'render a form when admin login' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      get :edit, params: {id: service.id}

      expect(response.body).to include('<form')
      expect(response.body).to include('Edit service')
    end
  end

  describe 'POST create' do

    it 'ask for login when not sign in' do
      post :create, params: {service: service_params}

      expect(response.code).to eq('302')
      expect(response.body).to include('sign_in')
    end

    it 'shows an error when is not admin' do
      sign_in(user_customer)

      post :create, params: {service: service_params}

      expect(response.body).not_to include('Create a service')
    end

    it 'creates the new record' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer
      expect{
        post :create, params: {service: service_params}
      }.to change{(Service.count)}.by(1)
    end

    it 'redirect to the new service' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer
      post :create, params: {service: service_params}
      expect(response.code).to eq('302')
    end

    it 'displays the form again when there is error' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer
      post :create, params: {service: service_invalid_params}
      expect(response.body).to include('Create a service')
      expect(response.body).to include('prohibited this service from being saved')
    end
  end

  describe 'PUT update' do
    let(:service) {service = Service.create!(service_params)}

    it 'ask for login when not sign in' do
      put :update, params: {id: service.id, service: service_params_2}

      expect(response.code).to eq('302')
      expect(response.body).to include('sign_in')
    end

    it 'shows an error when is not admin' do
      sign_in(user_customer)

      put :update, params: {id: service.id, service: service_params_2}

      expect(response.body).not_to include('Edit service')
    end

    it 'update the service when is admin' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      expect{
        put :update, params: {id: service.id, service: service_params_2}
        }.to change{
          service.reload.name
        }
    end

    it 'dispalys the form again when there is an error' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      put :update, params: {id: service.id, service: service_invalid_params}

      expect(response.body).to include('prohibited this service from being saved')
    end
  end

  describe 'DELETE #destroy' do
    let(:service) {Service.create!(service_params)}

    it 'ask for login when not sign in' do
      delete :destroy, params: {id: service.id}

      expect(response.code).to eq('302')
      expect(response.body).to include('sign_in')
    end

    it 'shows an error when is not admin' do
      sign_in(user_customer)

      delete :destroy, params: {id: service.id}

      expect(response.body).not_to include('Edit service')
      expect(response.body).to include("The page you were looking for doesn't exist")
    end

    it 'delete the record and redirect when is admin' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      delete :destroy, params: {id: service.id} 
      
      expect(response.code).to eq('302')
      expect(response.body).to eq('Services')
    end
  end
end
















