postdeploy: bundle install && bundle exec rails db:migrate
worker: bundle exec sidekiq -q default
scheduler: IS_SCHEDULER=true bundle exec sidekiq -q default