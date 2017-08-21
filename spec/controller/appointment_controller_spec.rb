require 'rails_helper'
require 'database_cleaner'

RSpec.describe AppointmentsController, type: :controller do
  render_views

  let!(:store) { Store.create!( name: "company name", location: "418 7th Ave Brooklyn", open_hour: Time.local(2002, 10, 1, 8, 0, 0),close_hour: Time.local(2002, 10, 1, 22, 0, 0), description: "An Exclusive SPA, ", phone_number: '1234567890' ) }

  let(:user_admin){
    User.create!(name: 'admin', email: 'admin@gmail.com', password: '123456', phone_number: '6469155917')
  }

  let(:user_customer){
    user_customer = User.create!(name: 'Mike', email: 'mike@gmail.com', password: '123456', phone_number: 987654321)
  }

  let(:user_customer2){
    user_customer = User.create!(name: 'Andy', email: 'andy@gmail.com', password: '123456', phone_number: 987111321)
  }

  let!(:staff){ store.staffs.create!( name: 'John', phone_number: '6469162183' ) }

  let!(:staff2){ store.staffs.create!( name: 'Jin', phone_number: '6469160000' ) }

  let(:service){ Service.create!({ name: 'massage', duration: '60', price: '90',description: 'Hydrating, brightening and firm the skin.', category: 'special treatment' })}

  let!(:appointment_params){ {name: 'Michael', date_time: Time.local(2018, 10, 1, 10, 0, 0),email: 'sfsdf@fsd.com', phone_number: '6362932934', service_ids:service.id, store_id:staff.store_id} }

  let(:appointment_params_2){ {name: 'asdf', date_time: Time.local(2018, 10, 1, 10, 0, 0),email: 'sfsdf@fsd.com', phone_number: '6362988884', service_ids:service.id, store_id:staff.store_id} }

  let(:appointment_params_past){ {name: 'past', date_time: Time.local(2000, 10, 1, 10, 0, 0),email: 'sfsdf@fsd.com', phone_number: '6362988884', service_ids:service.id, store_id:staff.store_id} }

  let(:appointment_before_open_params){ {name: 'past', date_time: Time.local(2022, 10, 1, 7, 0, 0),email: 'sfsdf@fsd.com', phone_number: '6362988884', service_ids:service.id, store_id:staff.store_id} }

  let(:appointment_after_close_params){ {name: 'past', date_time: Time.local(2022, 10, 1, 23, 0, 0),email: 'sfsdf@fsd.com', phone_number: '6362988884', service_ids:service.id, store_id:staff.store_id} }

  let!(:appointment_invalid_params){ {name: 'Michael',date_time: Time.local(2018, 10, 1, 10, 0, 0), email: 'sfsdf@fsd.com', service_ids:service.id, store_id:staff.store_id} }

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
      expect(response.body).to include('Start time')
      expect(response.body).to include("#{appointment.name}")
    end

    it 'has a link to amdin panel' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      get :show, params: { id: appointment.id, store_id: store.id }

      expect(response.body).to include('Back to calendar')
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
    let!(:appointment){ staff.appointments.create!(appointment_params)}
    let!(:appointment2){ staff.appointments.create!(appointment_params_2)}
    let!(:appointment3){ staff2.appointments.create!(appointment_params)}
    it 'render a 404 for non-existent staff' do

      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      get :staff_appointments, params: { store_id: store.id, id: -1}

      expect(response.body).to include("The page you were looking for doesn't exist")
    end

    it 'render a 404 for non-existent store' do

      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      get :staff_appointments, params: { store_id: -1, id: appointment.id }

      expect(response.body).to include("The page you were looking for doesn't exist")
    end

    it 'shows all the appointment from now to the future' do
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      get :staff_appointments, params: { store_id: store.id, id: staff.id}

      expect(response.body).not_to include(staff2.name)
      expect(response.body).to include(staff.name)
      expect(response.body).to include(appointment_params_2[:name])
      expect(staff.appointments.count).to eq(2)
    end

    it 'will not show past appointments ' do

      staff.appointments.create!(appointment_params_past)
      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      get :staff_appointments, params: { store_id: store.id, id: staff.id}

      expect(response.body).not_to include(staff2.name)
      expect(response.body).to include(staff.name)
      expect(staff.appointments.count).to eq(3)
    end
  end

  describe 'GET #customer_appointments' do
    let!(:appointment){ staff.appointments.create!(appointment_params)}
    let!(:appointment2){ staff.appointments.create!(appointment_params_2)}
    let!(:appointment3){ staff2.appointments.create!(appointment_params)}

    it 'redirect to login page if not login' do
      get :customer_appointments

      expect(response.code).to eq("302")
    end

    it 'shows all the appointments for right customer upcoming' do
      sign_in(user_customer)
      user_customer.appointments.create!(appointment_params.merge({staff_id: staff.id}))
      user_customer.appointments.create!(appointment_params_past.merge({staff_id: staff.id}))
      user_customer2.appointments.create!(appointment_params_2.merge({staff_id: staff.id}))
      get :customer_appointments

      expect(response.body).to include(appointment_params[:name])
      expect(response.body).not_to include(appointment_params_past[:name])
      expect(response.body).not_to include(appointment_params_2[:name])
    end
  end

  describe 'POST create' do

    it 'creates a new record' do
      expect{
        post :create, params: {appointment: appointment_params.merge({staff_id: staff.id }), store_id: store.id}
      }.to change{(Appointment.count)}.by(1)
    end

    it 'redirect to the created appointment' do

      post :create, params: {appointment: appointment_params.merge({ store_id: store.id, staff_id: staff.id }), store_id: store.id}

      expect(response.code).to eq('302')
    end

    it 'displays the form again when there is error' do

      post :create, params: { appointment: appointment_invalid_params.merge({ staff_id: staff.id }), store_id: store.id }

      expect(response.body).to include('Create an appointment')
      expect(response.body).to include('Phone number can&#39;t be blank')
    end

    it 'displays the form again when there the appointment time is before store open' do

      post :create, params: { appointment: appointment_before_open_params.merge({ staff_id: staff.id }), store_id: store.id }

      expect(response.body).to include('Create an appointment')
    end

    it 'displays the form again when there the appointment time is after store close' do
      
      post :create, params: { appointment: appointment_after_close_params.merge({ staff_id: staff.id }), store_id: store.id }

      expect(response.body).to include('Create an appointment')
    end

    it 'creates a new record when log in with customer account' do

      sign_in(user_customer)

      expect{
        post :create, params: {appointment: appointment_params.merge({staff_id: staff.id }), store_id: store.id}
      }.to change{(Appointment.count)}.by(1)
    end

    it 'creates a new record when log in with admin acoount' do

      sign_in(user_admin)
      user_admin.add_role :admin
      user_admin.remove_role :customer

      expect{
        post :create, params: {appointment: appointment_params.merge({staff_id: staff.id }), store_id: store.id}
      }.to change{(Appointment.count)}.by(1)
    end
  end
end









