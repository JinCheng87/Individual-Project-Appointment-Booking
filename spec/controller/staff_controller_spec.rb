require 'rails_helper'
require 'database_cleaner'

RSpec.describe StaffsController, type: :controller do
  render_views

  let(:store) { Store.create!( name: "company name", location: "418 7th Ave Brooklyn", open_hour: Time.new(2002, 10, 1, 8, 0, 0),close_hour: Time.new(2002, 10, 1, 22, 0, 0), description: "An Exclusive SPA, ", phone_number: '1234567890' ) }

  let(:user_admin){
    User.create!(name: 'admin', email: 'admin@gmail.com', password: '123456', phone_number: '6469155917')
  }

  let(:user_customer){
    user_customer = User.create!(name: 'Mike', email: 'mike@gmail.com', password: '123456', phone_number: 987654321)
  }

  let(:staff_params){ {name: 'John', phone_number: '6469162183'} }

  let(:staff_params_2){ {name: 'Lee', phone_number: '6469162199'} }

  let(:staff_invalid_params){ {name: nil, phone_number: '6469162199'} }

  describe 'GET #index' do

    it 'shows no staffs when it is empty' do
      get :index, params: {store_id: store.id}

      expect(response.body).to include('No staff available')
    end

    it 'list all the staffs' do
      staff = store.staffs.create!(staff_params)
      staff2 = store.staffs.create!(staff_params_2)

      get :index, params: {store_id: store.id}

      expect(Staff.count).to eq(2)
      expect(response.body).to include("#{staff.name}")
      expect(response.body).to include("#{staff2.name}")
      expect(response.body).to include('<img')
    end

    it 'does not have a add_staff button when is not admin nor customer' do

      get :index, params: {store_id: store.id}

      expect(response.body).to_not include("Add Employee")
    end

    it 'does not have a add_staff button when login as customer' do

      sign_in(user_customer)

      get :index, params: {store_id: store.id}

        expect(response.body).to_not include("Add Employee")
    end

    it 'has a add_staff button when login as admin' do

      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      get :index, params: {store_id: store.id}

      expect(response.body).to include("Add Employee")
    end
  end

  describe 'GET #new' do
    it 'ask for login when not sign in' do
      get :new, params: {store_id: store.id}

      expect(response.code).to eq('302')
      expect(response.body).to include('sign_in')
    end

    it 'shows an error when is not admin' do
      sign_in(user_customer)

      get :new, params: {store_id: store.id}

      expect(response.body).not_to include('Create a employee')
    end

    it 'render a form when admin login' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      get :new, params: {store_id: store.id}

      expect(response.body).to include('<form')
      expect(response.body).to include('Create a employee')
    end
  end


  describe 'GET show' do
    it 'render a 404 for non-existent staff' do
      get :show, params: { store_id: store.id, id: -1}

      expect(response.body).to include("The page you were looking for doesn't exist")
    end

    it 'render details of individule staff' do
      staff = store.staffs.create!(staff_params)

      get :show, params: { store_id: store.id, id: staff.id}

      expect(response.body).to include('Staff details')
      expect(response.body).to include('Name')
      expect(response.body).to include(staff.name)
      expect(response.body).to include('Phone number')
    end
  end

  describe 'GET edit' do
    let(:staff){ staff = store.staffs.create!(staff_params) }
    it 'ask for login when not sign in' do
      get :edit, params: { store_id: store.id, id: staff.id }

      expect(response.code).to eq('302')
      expect(response.body).to include('sign_in')
    end

    it 'shows an error when is not admin' do
      sign_in(user_customer)

      get :edit, params: { store_id: store.id, id: staff.id }

      expect(response.body).not_to include('Create')
    end

    it 'render a form when admin login' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      get :edit, params: { store_id: store.id, id: staff.id }

      expect(response.body).to include('<form')
      expect(response.body).to include('Edit staff')
    end
  end

    describe 'POST create' do

    it 'ask for login when not sign in' do
      post :create, params: { store_id: store.id }

      expect(response.code).to eq('302')
      expect(response.body).to include('sign_in')
    end

    it 'shows an error when is not admin' do
      sign_in(user_customer)

      post :create, params: { store_id: store.id, staff: staff_params }

      expect(response.body).not_to include('Create a staff')
    end

    it 'creates the new record' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer
      expect{
        post :create, params: { store_id: store.id, staff: staff_params }
      }.to change{(Staff.count)}.by(1)
    end

    it 'redirect to the new service' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer
      post :create, params: { store_id: store.id, staff: staff_params }
      expect(response.code).to eq('302')
    end

    it 'displays the form again when there is error' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer
      post :create, params: { store_id: store.id, staff: staff_invalid_params }
      expect(response.body).to include('Create a employee')
      expect(response.body).to include('prohibited this staff from being saved')
    end
  end

  describe 'PUT update' do
    let(:staff) {staff = store.staffs.create!(staff_params)}

    it 'ask for login when not sign in' do
      put :update, params: { id: staff.id, store_id: store.id }

      expect(response.code).to eq('302')
      expect(response.body).to include('sign_in')
    end

    it 'shows an error when is not admin' do
      sign_in(user_customer)

      put :update, params: { id: staff.id, store_id: store.id }

      expect(response.body).not_to include('Edit staff')
    end

    it 'update the service when is admin' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      expect{
        put :update, params: { id: staff.id, store_id: store.id, staff: staff_params_2 }
        }.to change{
          staff.reload.name
        }
    end

    it 'dispalys the form again when there is an error' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      put :update, params: { id: staff.id, store_id: store.id, staff: staff_invalid_params }

      expect(response.body).to include('prohibited this staff from being saved')
    end
  end

  describe 'DELETE #destroy' do
    let(:staff) {staff = store.staffs.create!(staff_params)}

    it 'ask for login when not sign in' do
      delete :destroy, params: { id: staff.id, store_id: store.id }
      expect(response.code).to eq('302')
      expect(response.body).to include('sign_in')
    end

    it 'shows an error when is not admin' do
      sign_in(user_customer)

      delete :destroy, params: { id: staff.id, store_id: store.id }

      expect(response.body).to include("The page you were looking for doesn't exist")
    end

    it 'delete the record and redirect when login as admin' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      delete :destroy, params: { id: staff.id, store_id: store.id } 
      
      expect(response.code).to eq('302')
    end
  end
end