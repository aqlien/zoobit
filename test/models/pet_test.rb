require "test_helper"

class PetTest < ActiveSupport::TestCase

  def pet
    @pet ||= Pet.new
  end

  def test_valid
    assert pet.valid?
  end

end
