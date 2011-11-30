Gormify::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true
  
  Paperclip.options[:command_path] = "/c/Program Files/ImageMagick-6.7.3-Q8/convert"

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
  
  config.after_initialize do
    ActiveMerchant::Billing::PaypalExpressGateway.default_currency = 'GBP'
    ActiveMerchant::Billing::Base.mode = :test
    paypal_options = {
      :login => "ben-go_1322070516_biz_api1.hotmail.co.uk",
      :password => "1322070557",
      :signature => "AqP-WMxakBZ7qhQxorGVUyvJwlTkAojF6u8Qusqu2Y3G6VvJw72D8u6w"
    }
    ::STANDARD_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
    ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
  end
   config.action_mailer.delivery_method = :smtp
   
   config.action_mailer.smtp_settings = {
    :address        => 'havana.footholds.net',
    :port           => 26,
    :domain         => 'havana.footholds.net',
    :authentication => :login,
    :user_name      => 'misocure+benjgorman.com',
    :password       => 'twistedtail'
  }
end