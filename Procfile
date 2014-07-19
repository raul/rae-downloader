console: bundle exec ruby -e 'require "./lib/rae-downloader"; require "irb"; IRB.start'
schedule: bundle exec rake words:schedule
seed: bundle exec rake words:seed
stats: bundle exec rake words:stats
worker: bundle exec sidekiq -c $DATABASE_POOL_SIZE -r ./lib/rae-downloader.rb
