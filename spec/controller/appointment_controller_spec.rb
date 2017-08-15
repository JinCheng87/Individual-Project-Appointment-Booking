require 'rails_helper'
require 'database_cleaner'

RSpec.describe AppointmentsController, type: :controller do
  render_views

  let(:store) { Store.create!( name: "company name", location: "418 7th Ave Brooklyn", hours: '10AM-10PM', description: "An Exclusive SPA, ", phone_number: '1234567890' ) }

  let(:user_admin){
    User.create!(name: 'admin', email: 'admin@gmail.com', password: '123456', phone_number: '6469155917')
  }

  let(:user_customer){
    user_customer = User.create!(name: 'Mike', email: 'mike@gmail.com', password: '123456', phone_number: 987654321)
  }

  let(:staff){ store.staffs.create!( name: 'John', phone_number: '6469162183' ) }

  let(:service){ Service.create!({ name: 'massage', duration: '60', price: '90',description: 'Hydrating, brightening and firm the skin.', category: 'special treatment' })}

  let(:appointment_params){ {name: 'Michael', date_time: Time.zone.now + 1.day,email: 'sfsdf@fsd.com', phone_number: '6362932934', service_ids:service.id, store_id:staff.store_id} }

  let(:appointment_params_2){ {name: 'Michael', date_time: Time.zone.now + 2.day,email: 'sfsdf@fsd.com', phone_number: '6362932934', service_ids:service.id, store_id:staff.store_id} }

  describe 'GET #new' do
    it 'render a appointment form' do

      get :new, params: {store_id: store.id}

      expect(response.body).to include('<form')
      expect(response.body).to include('Create an appointment')
    end
  end

  describe 'GET show' do
    let(:appointment){ staff.appointments.create!(appointment_params)}
    it 'render a 404 for non-existent staff' do
      get :show, params: { store_id: store.id, id: -1}

      expect(response.body).to include("The page you were looking for doesn't exist")
    end

    it 'ask for login when not admin and do not have a token' do
      get :show, params: { id: appointment.id, store_id: store.id }

      expect(response.code).to eq('302')
      expect(response.body).to include('sign_in')
    end

    it 'shows an error when is not admin and do not have a token' do
      sign_in(user_customer)

      get :show, params: { id: appointment.id, store_id: store.id }

      expect(response.body).not_to include('Appointment details')
    end

    it 'shows the appointment when is admin' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      get :show, params: { id: appointment.id, store_id: store.id }

      expect(response.body).to include('Appointment details')
      expect(response.body).to include("Start time")
      expect(response.body).to include("#{appointment.name}")
    end

    it 'shows the appointment when has a token' do

      get :show, params: { id: appointment.id, store_id: store.id, token: appointment.token }

      expect(response.body).to include('Appointment details')
      expect(response.body).to include("Start time")
      expect(response.body).to include("#{appointment.name}")
    end
  end

  describe 'GET #edit' do
    let(:appointment){ staff.appointments.create!(appointment_params)}

    it 'render a 404 for non-existent staff' do
      get :edit, params: { store_id: store.id, id: -1}

      expect(response.body).to include("The page you were looking for doesn't exist")
    end

    it 'ask for login when not admin and do not have a token' do
      get :edit, params: { id: appointment.id, store_id: store.id }

      expect(response.code).to eq('302')
      expect(response.body).to include('sign_in')
    end

    it 'shows an error when is not admin and do not have a token' do
      sign_in(user_customer)

      get :edit, params: { id: appointment.id, store_id: store.id }

      expect(response.body).not_to include('Edit appointment')
    end

    it 'shows the appointment when is admin' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      get :edit, params: { id: appointment.id, store_id: store.id }

      expect(response.body).to include('Edit appointment')
      expect(response.body).to include("Date time")
      expect(response.body).to include("#{appointment.name}")
    end

    it 'shows the appointment when has a token' do

      get :edit, params: { id: appointment.id, store_id: store.id, token: appointment.token }

      expect(response.body).to include('Edit appointment')
      expect(response.body).to include("Date time")
      expect(response.body).to include("#{appointment.name}")
    end 
  end

  describe 'GET #staff_appointments' do
    let(:appointment){ staff.appointments.create!(appointment_params)}
    let(:appointment2){ staff.appointments.create!(appointment_params_2)}

    it 'render a 404 for non-existent staff' do

      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      get :staff_appointments, params: { store_id: store.id, id: "-1"}

      expect(response.body).to include("The page you were looking for doesn't exist")
    end
  end
end









