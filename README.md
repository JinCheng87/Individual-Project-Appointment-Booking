# README

###Set up redis resque with:
Add Redis-server to background: redis-server --daemonize yes
heroku addons:create redistogo
heroku config:set REDIS_PROVIDER=REDISTOGO_URL
In Procfile added:
redis: redis-server
web: bundle exec rails s
worker: QUEUE=* bundle exec rake environment resque:work
config/initializers/redis.rb:
uri = ENV["REDISTOGO_URL"] || "redis://localhost:6379/"
REDIS = Redis.new(:url => uri)

##rake task located: ./lib/tasks/*.rake