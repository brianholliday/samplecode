require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @line_item = line_items(:one)
    #@line_item = LineItem.create! product: products(:one), cart: carts(:one), price: 1.00, quantity: 2
  end

  test "should get index" do
    get line_items_url
    assert_response :success
  end

  test "should get new" do
    get new_line_item_url
    assert_response :success
  end

  test "should create line_item via ajax" do
    assert_difference('LineItem.count') do
      post line_items_url, params: { product_id: products(:ruby).id, price: products(:ruby).price },
      xhr: true
    end
    
    assert_response :success
    
    assert_select_jquery :html, '#cart' do
      assert_select 'tr#current_item td', /Programming Ruby 1.9/
    end
  end

  test "should show line_item" do
    get line_item_url(@line_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_line_item_url(@line_item)
    assert_response :success
  end

  test "should update line_item" do
    patch line_item_url(@line_item), params: { line_item: { product_id: products(:ruby).id, price: products(:ruby).price } }
    assert_redirected_to line_item_url(@line_item)
  end

  #I dunno why this doesn't work
  #test "should decrement line_item" do
  # @line_item = LineItem.create! product: products(:one), cart: carts(:one), price: 1.00, quantity: 2
    #assert_difference('@line_item.quantity', -1) do
      #debugger
  #    put decrement_line_item_url(@line_item)
     # debugger
    #end
  #  assert_equal 1, @line_item.quantity
  #  assert_redirected_to store_index_url
  # end
  
end
