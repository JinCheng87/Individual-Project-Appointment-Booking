require 'rails_helper'
require 'database_cleaner'


RSpec.describe StoresController, type: :controller do
  render_views

  let(:store_params){ {name: "company name", location: "418 7th Ave Brooklyn", hours: '10AM-10PM', description: "An Exclusive SPA "} }

  let(:user_admin){
    User.create!(name: 'admin', email: 'admin@gmail.com', password: '123456', phone_number: Faker::PhoneNumber.cell_phone)

  }
  let(:user_customer){
    user_customer = User.create!(name: 'Mike', email: 'mike@gmail.com', password: '123456', phone_number: Faker::PhoneNumber.cell_phone)
  }

  let(:store1){ Store.create!(store_params) } 

  describe 'GET #edit' do
    it 'allow admin to  edit the store information' do
      user_admin.add_role :admin
      user_admin.remove_role :customer
      sign_in(user_admin)

      get :edit, params: { id: store1.to_param }

      expect(response.body).to include('Edit store')
    end

    it 'not allow customer to edit the store information' do
      sign_in(user_customer)

      get :edit, params: { id: store1.to_param }

      expect(response.body).not_to include('Edit store')
      expect(response.status).to eq(302)
    end

    it 'not allow non admin to edit the store information' do
      sign_in(user_customer)
      store1 = Store.create!(store_params)

      get :edit, params: { id: store1.to_param }

      expect(response.body).not_to include('Edit store')
      expect(response.status).to eq(302)
    end
  end

  describe 'GET #show' do

    it 'shows store details' do
      get :show, params: {id: store1.to_param}

      expect(response.body).to include('Store: company name')
      expect(response.body).to include('Location: 418 7th Ave Brooklyn')
      expect(response.body).to include('View staffs')
      expect(response.body).to include('Make a reservation')
    end

    it 'shows admin exclusive links' do
      user_admin.add_role :admin
      user_admin.remove_role :customer
      sign_in(user_admin)

      get :show, params: {id: store1.to_param}

      expect(response.body).to include('Edit')
      expect(response.body).to include('View the calendar')
      expect(response.body).to include('Add staff')
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) { {name: "another company", location: "4215 fort hamilton", hours: '9AM-9PM', description: "An Exclusive SPA"} }

    let(:invalid_attributes) { {name: nil, location: "4215 fort hamilton", hours: '9AM-9PM', description: "An Exclusive SPA"} }

    it 'update the store information' do
      user_admin.add_role :admin
      user_admin.remove_role :customer
      sign_in(user_admin)

      put :update, params:{ id: store1.to_param, store: new_attributes} 

      store1.reload
      expect(store1.name).to eq("another company")
      expect(store1.description).to eq("An Exclusive SPA")
    end

    it 'redirect to the store datail page' do
      user_admin.add_role :admin
      user_admin.remove_role :customer
      sign_in(user_admin)

      put :update, params:{ id: store1.to_param, store: new_attributes} 

      expect(response).to redirect_to("/stores/#{store1.id}")
    end

    it 're-render the edit template when the input is invalid' do
      user_admin.add_role :admin
      user_admin.remove_role :customer
      sign_in(user_admin)

      put :update, params:{ id: store1.to_param, store: invalid_attributes}

      expect(response.body).to include("Edit store")
      expect(response.body).to include("Name can&#39;t be blank")
    end

    it 'not allow non-admin to edit the store' do
      sign_in(user_customer)

      put :update, params:{ id: store1.to_param, store: new_attributes}

      expect(response.body).to include("404")
      expect(response.status).to eq(302)
    end
  end
end