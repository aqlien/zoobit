require "test_helper"

class BirdTest < ActiveSupport::TestCase

  def bird
    @bird ||= Bird.new
  end

  def test_valid
    assert bird.valid?
  end

end
