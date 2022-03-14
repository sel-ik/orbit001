require "test_helper"

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @relationship = Relationship.new(follower_id: users(:tony).id,
                                     followed_id: users(:jane).id)
  end

  test "Should be valid" do
    assert @relationship.valid?
  end

  test "Should require a follower id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "Should require a followed id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
