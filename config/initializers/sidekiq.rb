require 'sidekiq'
require 'sidekiq/web'
require 'yaml'
require 'sidekiq-scheduler'
require 'sidekiq-scheduler/web'
redis_url = ENV['REDIS_URL']

Sidekiq.strict_args!(false)
Sidekiq.configure_server do |config|
  config.on(:startup) do
    # Sidekiq::Scheduler.dynamic = true
    # Sidekiq.schedule = YAML.load_file(File.expand_path('../../sidekiq_scheduler.yml', __FILE__))
    # SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
  config.redis = { url: redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end
