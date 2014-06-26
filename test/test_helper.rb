require 'simplecov'
SimpleCov.start 'rails'
SimpleCov.command_name "MiniTest"

Rails.env ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails"
require "minitest/rails/capybara"

include Devise::TestHelpers

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  fixtures :all
end

def sign_in_capybara(login = users(:sam).email, password = "password", fail_sign_in = false)
  click_on I18n.t(:sign_in_link)
  fill_in "Login", with: login
  fill_in "Password", with: password
  click_on "Submit"
  page.must_have_content I18n.t("devise.sessions.signed_in") unless fail_sign_in
end

def setup_omniauth_for_testing
  visit root_path
  OmniAuth.config.test_mode = true
  Capybara.current_session.driver.request.env['devise.mapping'] = Devise.mappings[:user]
  click_on I18n.t(:sign_in_link)
end

def seed_db
  User.create(username: "Zoobit Shelter", email: "shelter@zoobit.net", id: 1, password: "zoobit123")
end
