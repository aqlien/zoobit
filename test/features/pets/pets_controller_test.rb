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
    post :create, pet: {name: "Joe", type: "Dog", gender:"female"}
    assert_redirected_to pet_path(assigns(:pet))
  end

  test "destroy a pet" do
    pet = Pet.create(name: "Joe", type: "Dog", gender:"female")
    pet.save
    users(:sam).pets << pet
    delete :destroy, id: Pet.find(pet.id)
    assert_response :success
  end
end
