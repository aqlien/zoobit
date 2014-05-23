require "test_helper"

class RabbitsControllerTest < ActionController::TestCase

  def rabbit
    @rabbit ||= rabbits :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:rabbits)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Rabbit.count') do
      post :create, rabbit: {  }
    end

    assert_redirected_to rabbit_path(assigns(:rabbit))
  end

  def test_show
    get :show, id: rabbit
    assert_response :success
  end

  def test_edit
    get :edit, id: rabbit
    assert_response :success
  end

  def test_update
    put :update, id: rabbit, rabbit: {  }
    assert_redirected_to rabbit_path(assigns(:rabbit))
  end

  def test_destroy
    assert_difference('Rabbit.count', -1) do
      delete :destroy, id: rabbit
    end

    assert_redirected_to rabbits_path
  end
end
