require "bundler/setup"
Bundler.require

$stdout.sync = true

require "./app"

Slim::Engine.set_default_options pretty: true

map "/assets" do
  assets = Sprockets::Environment.new do |env|
    env.append_path(settings.root + "/assets/images")
    env.append_path(settings.root + "/assets/javascripts")
    env.append_path(settings.root + "/assets/stylesheets")
    env.logger = Logger.new($stdout)
  end
  run assets
end

map "/" do
  use Rack::Instruments
  run Sinatra::Application
end
