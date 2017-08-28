Appointment-booking
=======================
[![Build Status](https://travis-ci.org/JinCheng87/Individual-Rails-Project-Appointment-Booking.svg?branch=master)](https://travis-ci.org/JinCheng87/Individual-Rails-Project-Appointment-Booking)

Set up redis and resque:
==========================

    * redis-cli shutdown

Rake task located
===================
  ./lib/tasks/*.rake

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

  * Every hour check if there is any appointment coming up in 5 hours, send a notification textmessage to these customers(once sent, mark as 'has_been_reminded')
  * Every month find all the appointments that 6 month old, delete all those appointments.
