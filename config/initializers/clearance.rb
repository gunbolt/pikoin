if Rails.env.test?
  Rails.application.config.middleware.use Clearance::BackDoor
end

Rails.application.config.to_prepare do
  Clearance::SessionsController.rate_limit(
    to: 4,
    within: 1.minute,
    only: :create
  )
end

Clearance.configure do |config|
  config.allow_sign_up = false
  config.allow_password_reset = false
  config.mailer_sender = "reply@example.com"
  config.rotate_csrf_on_sign_in = true
  config.signed_cookie = true

  # DEFAULT CONFIG
  # config.allow_sign_up = true
  # config.allow_password_reset = true
  # config.cookie_domain = ".example.com"
  # config.cookie_expiration = lambda { |cookies| 1.year.from_now.utc }
  # config.cookie_name = "remember_token"
  # config.cookie_path = "/"
  # config.routes = true
  # config.httponly = true
  # config.mailer_sender = "reply@example.com"
  # config.password_strategy = Clearance::PasswordStrategies::BCrypt
  # config.redirect_url = "/"
  # config.url_after_destroy = nil
  # config.url_after_denied_access_when_signed_out = nil
  # config.rotate_csrf_on_sign_in = true
  # config.same_site = nil
  # config.secure_cookie = Rails.configuration.force_ssl
  # config.signed_cookie = false
  # config.sign_in_guards = []
  # config.user_model = "User"
  # config.parent_controller = "ApplicationController"
  # config.sign_in_on_password_reset = false
end
