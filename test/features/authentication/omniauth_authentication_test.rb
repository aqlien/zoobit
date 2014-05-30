require "test_helper"

feature "Mock Twitter Authentication" do
  before do
    setup_omniauth_for_testing
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({provider: 'twitter', uid: '12345'})
    Capybara.current_session.driver.request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
    OmniAuth.config.add_mock(:twitter,{uid: '12345',info: { nickname: 'test_twitter_user'},})
  end
  scenario "sign in with Twitter" do
    click_on "Sign in with Twitter"
    page.must_have_content I18n.t("devise.sessions.signed_in")
  end
end

feature "Mock Facebook Authentication" do
  before do
    setup_omniauth_for_testing
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({provider: 'facebook', uid: '12345'})
    Capybara.current_session.driver.request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    OmniAuth.config.add_mock(:facebook,{uid: '12345',info: { nickname: 'test_facebook_user'},})
  end
  scenario "sign in with Facebook" do
    click_on "Sign in with Facebook"
    page.must_have_content I18n.t("devise.sessions.signed_in")
  end
end


