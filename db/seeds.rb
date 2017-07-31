# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
4.times do 
  Store.create(name: Faker::Company.name, location: Faker::Address.street_address, hours: "7/24", description: "very good place!")
end

Store.all.each do |store|
  6.times do
    store.staffs.create(name: Faker::Name.name, phone_number: Faker::PhoneNumber.cell_phone)
    store.appointments.create(name: Faker::Name.name, date_time: Faker::Time.between(DateTime.now + 1, DateTime.now),email: Faker::Internet.email, phone_number: Faker::PhoneNumber.cell_phone, staff_id:rand(6)+1, )
    store.appointments.create(name: Faker::Name.name, date_time: Faker::Time.between(DateTime.now - 1, DateTime.now),email: Faker::Internet.email, phone_number: Faker::PhoneNumber.cell_phone, staff_id:rand(6)+1, )
  end
end

Service.create(name: '30 mins massage', duration: '30', price: '100')
Service.create(name: '45 mins massage', duration: '45', price: '120')
Service.create(name: '60 mins massage', duration: '60', price: '200')
Service.create(name: '90 mins massage', duration: '90', price: '300')
Service.create(name: '120 mins massage', duration: '120', price: '400')

Appointment.all.each do |app|
  app.services << Service.all[rand(5)]
end

user1 = User.create(name: 'Jin', email: 'sw02102@gmail.com', password: '123456', phone_number: Faker::PhoneNumber.cell_phone)
user2 = User.create(name: 'Mike', email: 'mike@gmail.com', password: '123456', phone_number: Faker::PhoneNumber.cell_phone)
user1.add_role :admin
user1.remove_role :customer



