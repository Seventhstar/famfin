require_relative 'boot'

require 'rails/all'

require_relative  '../lib/ext/integer'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Familyfin
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]    
    config.i18n.enforce_available_locales = true
    config.i18n.available_locales = %i(en ru)
    config.i18n.default_locale = :ru

    config.assets.enabled = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
