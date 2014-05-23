require "test_helper"

class DogTest < ActiveSupport::TestCase

  def dog
    @dog ||= Dog.new
  end

  def test_valid
    assert dog.valid?
  end

end
