require "test_helper"

class BirdsControllerTest < ActionController::TestCase

  def bird
    @bird ||= birds :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:birds)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Bird.count') do
      post :create, bird: {  }
    end

    assert_redirected_to bird_path(assigns(:bird))
  end

  def test_show
    get :show, id: bird
    assert_response :success
  end

  def test_edit
    get :edit, id: bird
    assert_response :success
  end

  def test_update
    put :update, id: bird, bird: {  }
    assert_redirected_to bird_path(assigns(:bird))
  end

  def test_destroy
    assert_difference('Bird.count', -1) do
      delete :destroy, id: bird
    end

    assert_redirected_to birds_path
  end
end
