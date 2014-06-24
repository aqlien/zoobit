require "test_helper"

class FriendshipTest < ActiveSupport::TestCase

  def friendship
    @friendship ||= Friendship.new
  end

  def test_valid
    assert friendship.valid?
  end

end
