require "test_helper"

class SnapshotTest < ActiveSupport::TestCase

  def setup
    @user = users(:tony)

    @snapshot = @user.snapshots.build(content: "test content")
  end

  test "Should be valid" do
    assert @snapshot.valid?
  end

  test "User id should be present" do
    @snapshot.user_id = nil
    assert_not @snapshot.valid?
  end

  test "Content should be present" do
    @snapshot.content = "      "
    assert_not @snapshot.valid?
  end

  test "Content should be no more than 250 characters" do
    @snapshot.content = "a" * 251
    assert_not @snapshot.valid?
  end

  test "Order should be most recent snapshot first" do
    assert_equal snapshots(:most_recent), Snapshot.first
  end
end
