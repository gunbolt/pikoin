require "test_helper"
require "capybara/rails"
require "capybara/minitest"

# All component test classes should inherit ComponentTestCase
class ComponentTestCase < ActiveSupport::TestCase
  include Capybara::DSL
  include Capybara::Minitest::Assertions
  include Rails.application.routes.url_helpers

  attr_reader :page

  def view_context
    controller.view_context
  end

  def controller
    @controller ||= ActionView::TestCase::TestController.new
  end

  def render(...)
    @page = ::Capybara::Node::Simple.new(render_to_string(...))
  end

  def render_to_string(...)
    view_context.render(...)
  end
end
