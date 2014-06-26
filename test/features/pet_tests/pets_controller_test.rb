require "test_helper"


class PetsControllerTest < ActionController::TestCase
  before do
    seed_db
    sign_in users(:sam)
  end

  test "get the index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pets)
  end

  test "destroy a pet" do
    delete :destroy, id: Pet.find(pets(:whiskers).id)
    assert_redirected_to pets_path, flash[:notice]
  end
end
