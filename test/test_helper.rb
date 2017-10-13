require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'mocha/setup'
require 'minitest/reporters'
require 'authlogic/test_case'
require 'factory_girl_rails'

Minitest::Reporters.use!(
	Minitest::Reporters::ProgressReporter.new,
	ENV,
	Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  include Authlogic::TestCase
end

class ActionController::TestCase
  setup :activate_authlogic
end

def login user
  activate_authlogic unless UserSession.activated?
  logout
  user.reset_persistence_token!
  UserSession.create(user, true)
  post user_sessions_url, params: { user_session: { email: user.email, password: "Password12345" } }
end

def login_admin
  admin = create :admin_user
  login admin
  admin
end

def login_user
  user = create :user
  login user
  user
end

def logout
  UserSession&.find&.destroy
end

