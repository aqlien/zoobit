Rails.env ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails"
require "minitest/rails/capybara"

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  fixtures :all
end

def sign_in(login = users(:sam).email, password = "password", fail_sign_in = false)
  click_on I18n.t(:sign_in_link)
  fill_in "Login", with: login
  fill_in "Password", with: password
  click_on "Sign in"
  page.must_have_content I18n.t("devise.sessions.signed_in") unless fail_sign_in
end

def setup_omniauth_for_testing
  visit root_path
  OmniAuth.config.test_mode = true
  Capybara.current_session.driver.request.env['devise.mapping'] = Devise.mappings[:user]
  click_on I18n.t(:sign_in_link)
end

