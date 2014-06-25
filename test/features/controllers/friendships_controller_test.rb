require "test_helper"

feature "Friendship" do
  before do
    seed_db
    @friendship ||= friendships :one
    @user = users :alex
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:friendships)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    user = users :sam
    visit root_path
    sign_in_capybara
    visit user_friends_path(user)
    click_on "Search"
    click_on "Add ZoobitDev"
    assert_equal(user.friendships.count, 1)
  end

  def test_show
    get :show, id: friendship
    assert_response :success
  end

  def test_edit
    get :edit, id: friendship
    assert_response :success
  end

  def test_update
    put :update, id: friendship, friendship: { friend_id: @friendship.friend_id, status: @friendship.status, user_id: @friendship.user_id }
    assert_redirected_to friendship_path(assigns(:friendship))
  end

  def test_destroy
    assert_difference('Friendship.count', -1) do
      delete :destroy, id: friendship
    end

    assert_redirected_to friendships_path
  end
end
