require "test_helper"

class CatTest < ActiveSupport::TestCase

  def cat
    @cat ||= Cat.new
  end

  def test_valid
    assert cat.valid?
  end

end
