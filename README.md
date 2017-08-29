Appointment-booking
=======================
[![Build Status](https://travis-ci.org/JinCheng87/Individual-Project-Appointment-Booking.svg?branch=master)](https://travis-ci.org/JinCheng87/Individual-Project-Appointment-Booking)

https://appt-booking.herokuapp.com/

Appointment booking is a web application for small business owner to promote their business. Customers are able to book appointments through the website and get text messages reminding before appointments to reduce no shows. Admin panel allows owners to manage their appointments and employees.

Utilized Ruby on Rails, Boostrap, PostgreSQL, JavaScript, RSpec, jQuery

Functionality:
==========================

* Customers are able to visit the site read informations(e.g. pirce, addresses, services)

* Customers are also able to make an appointment for any branch of stores.(store owner can have multiple stores)

* After appointment is been made, customer will receive an email notification.(rails action mailer)

* In that Email notification customer are able to edit or cancel the appoiointment without sign in to account.(use token and heroku schedulr run rake task very hour to check upcoming appointments)

5 hours before appointment customer will receive a text message about the upcomming appointment.(twilio and rake task)

Admin are able to view and make appointments by canlendar.

If there is a employee on leave or come late, admin can block the employee's availablity so that customer won't be able to choose.(block by date and time)

Admin also are able to set the store hours, so that no one can make an appointment outside of store hours.

![screenshot](https://github.com/JinCheng87/Individual-Project-Appointment-Booking/blob/master/app/assets/images/Screen%20Shot.png)

Set up redis and resque:
==========================
  * Add Redis-server to background: `redis-server --daemonize yes`
  * heroku addons:`create redistogo`
  * heroku config:set `REDIS_PROVIDER=REDISTOGO_URL`
  * In Procfile added:
  `redis: redis-server
  web: bundle exec rails s
  worker: QUEUE=* bundle exec rake environment resque:work`
  * config/initializers/redis.rb:
  `uri = ENV["REDISTOGO_URL"] || "redis://localhost:6379/"
  REDIS = Redis.new(:url => uri)`

To stop redis running in the background
========================================
  * `redis-cli shutdown`

Rake task located
===================
 `./lib/tasks/*.rake`

Schedule tasks
===================
  * Every hour check if there is any appointment coming up in 5 hours, send a notification textmessage to these customers(once sent, mark as 'has_been_reminded')
  * Every month find all the appointments that 6 month old, delete all those appointments.
