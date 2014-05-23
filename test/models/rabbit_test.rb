require "test_helper"

class RabbitTest < ActiveSupport::TestCase

  def rabbit
    @rabbit ||= Rabbit.new
  end

  def test_valid
    assert rabbit.valid?
  end

end
