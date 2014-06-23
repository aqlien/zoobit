require "test_helper"

class FriendshipsControllerTest < ActionController::TestCase

  def friendship
    @friendship ||= friendships :one
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
    assert_difference('Friendship.count') do
      post :create, friendship: { friend_id: @friendship.friend_id, status: @friendship.status, user_id: @friendship.user_id }
    end

    assert_redirected_to friendship_path(assigns(:friendship))
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
