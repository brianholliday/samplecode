require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @line_item = line_items(:one)
  end
  
  test "should decrement quantity" do
    assert_difference('@line_item.quantity', -1) do
      @line_item.decrement
    end
  end
end
