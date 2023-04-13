require "test_helper"

class BlogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "draft? returns true for draft blog" do
    assert blogs(:draft).draft?
  end

  test "draft? returns false for published blog" do
    refute blogs(:published).draft?
  end

  test "draft? returns false for scheduled blog" do
    refute blogs(:scheduled).draft?
  end



  test "published? returns true for published blog" do
    assert blogs(:published).published?
  end

  test "published? returns false for draft blog" do
    refute blogs(:draft).published?
  end

  test "published? returns false for scheduled blog" do
    refute blogs(:scheduled).published?
  end

  
  
  test "scheduled? returns true for scheduled? blog" do
    assert blogs(:scheduled).scheduled?
  end

  test "scheduled? returns false for published blog" do
    refute blogs(:published).scheduled?
  end

  test "scheduled? returns false for draft blog" do
    refute blogs(:draft).scheduled?
  end

  
end
