require "clearance/test_unit"

module Clearance::RequestHelpers
  def sign_in
    user = create(:user, password: "test123")

    post session_path, params: {
      session: {email: user.email, password: "test123"}
    }
  end
end

ActiveSupport.on_load :action_dispatch_integration_test do
  include Clearance::RequestHelpers
end
