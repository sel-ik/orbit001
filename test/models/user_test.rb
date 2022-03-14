require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test User", email: "test@example.com",
       password: "password123", password_confirmation: "password123")
  end

  test "Should be valid" do
    assert @user.valid?
  end

  test "Name should be present" do
    @user.name = "          "
    assert_not @user.valid?
  end

  test "Email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "Name cannot be too long" do
    @user.name = "a" * 61
    assert_not @user.valid?
  end

  test "Email cannot be too long" do
    @user.email = "a" * 255 + "@example.com"
    assert_not @user.valid?
  end

  test "Email validation should accept valid email addresses" do
    valid_addresses = %w[selik@example.com JOHN@test.com MARY_smith-01@example.com tony+smith@example.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "Email validation should not accept invalid email addresses" do
    invalid_addresses = %w[test@example,com test_at_example.com test@example. test@ex+ample.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "Email address should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "Password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "Password should have minimum length" do
    @user.password = @user.password_confirmation = "p" * 5
    assert_not @user.valid?
  end

  test "Associated snapshots should be destroyed" do
    @user.save
    @user.snapshots.create!(content: "Great job!")
    assert_difference 'Snapshot.count', -1 do
      @user.destroy
    end
  end

  test "Should follow and unfollow a user" do
    tony = users(:tony)
    jane = users(:jane)
    assert_not tony.following?(jane)
    tony.follow(jane)
    assert tony.following?(jane)
    assert jane.followers.include?(tony)
    tony.unfollow(jane)
    assert_not tony.following?(jane)
  end
end
