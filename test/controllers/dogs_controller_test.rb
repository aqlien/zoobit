require "test_helper"

class DogsControllerTest < ActionController::TestCase

  def dog
    @dog ||= dogs :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:dogs)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Dog.count') do
      post :create, dog: {  }
    end

    assert_redirected_to dog_path(assigns(:dog))
  end

  def test_show
    get :show, id: dog
    assert_response :success
  end

  def test_edit
    get :edit, id: dog
    assert_response :success
  end

  def test_update
    put :update, id: dog, dog: {  }
    assert_redirected_to dog_path(assigns(:dog))
  end

  def test_destroy
    assert_difference('Dog.count', -1) do
      delete :destroy, id: dog
    end

    assert_redirected_to dogs_path
  end
end
