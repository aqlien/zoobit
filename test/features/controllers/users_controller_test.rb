require "test_helper"

feature "Users controller" do
  before do
    seed_db
  end

  scenario "users index is censored unless search explicitly looks for obscenity" do
    visit users_path
    page.has_no_content?("Fuck")
  end

end
