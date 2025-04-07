require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  parallelize(workers: 1)

  # See https://github.com/teamcapybara/capybara/pull/2773
  Selenium::WebDriver.logger.ignore(:clear_local_storage, :clear_session_storage)

  if ENV["CAPYBARA_SERVER_PORT"]
    served_by host: "rails-app", port: ENV["CAPYBARA_SERVER_PORT"]

    driven_by :selenium,
      using: :headless_firefox,
      screen_size: [1400, 1400],
      options: {browser: :remote, url: "http://#{ENV["SELENIUM_HOST"]}:4444"}
  else
    driven_by :selenium, using: :headless_firefox, screen_size: [1400, 1400]
  end
end
