Rails.env ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails"
require "minitest/rails/capybara"

class ActiveSupport::TestCase
  fixtures :all
end

def sign_in(login = users(:sam).email, password = "password")
  click_on I18n.t(:sign_in_link)
  fill_in "Login", with: login
  fill_in "Password", with: password
  click_on "Sign in"
end
