require_relative 'boot'

require 'rails/all'

require 'attachinary/orm/active_record'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mybandsource
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Gzip all text based responses served to the client.
    config.middleware.use Rack::Deflater
  end
end
