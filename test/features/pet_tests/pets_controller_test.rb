require "test_helper"


class PetsControllerTest < ActionController::TestCase
  before do
    sign_in users(:sam)
    User.create(username: "Zoobit Shelter", email: "shelter@zoobit.net", id: 1, password: "zoobit123")
  end

  test "get the index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pets)
  end

  test "create a new pet" do
    post :create, pet: {name: pets(:spot).name, type: pets(:spot).type, gender: pets(:spot).gender}
    assert_redirected_to pet_path(assigns(:pet))
  end

  test "destroy a pet" do
    delete :destroy, id: Pet.find(pets(:whiskers).id)
    assert_redirected_to pets_path, flash[:notice]
  end
end
