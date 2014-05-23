require "test_helper"

class CatsControllerTest < ActionController::TestCase

  def cat
    @cat ||= cats :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:cats)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Cat.count') do
      post :create, cat: {  }
    end

    assert_redirected_to cat_path(assigns(:cat))
  end

  def test_show
    get :show, id: cat
    assert_response :success
  end

  def test_edit
    get :edit, id: cat
    assert_response :success
  end

  def test_update
    put :update, id: cat, cat: {  }
    assert_redirected_to cat_path(assigns(:cat))
  end

  def test_destroy
    assert_difference('Cat.count', -1) do
      delete :destroy, id: cat
    end

    assert_redirected_to cats_path
  end
end
