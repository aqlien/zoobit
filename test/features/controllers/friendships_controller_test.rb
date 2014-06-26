require "test_helper"

feature "Friendship" do
  before do
    seed_db
    @friendship ||= friendships :one
    @user = users :sam
  end

  def test_index
    visit user_friends_path(@user)
    page.must_have_content User.find(@friendship.friend_id).username
  end

  def test_create
    visit root_path
    sign_in_capybara
    visit user_friends_path(@user)
    assert_equal(1, @user.friendships.count)
    click_on "Search"
    first(:link, "Add Friend").click
    assert_equal(2, @user.friendships.count)
  end

  def test_destroy
    assert_equal(@user.friendships.count, 1)
    assert_difference('@user.friendships.count', -1) do
      visit user_friends_path(@user)
      click_on "Unfriend"
    end
  end
end
