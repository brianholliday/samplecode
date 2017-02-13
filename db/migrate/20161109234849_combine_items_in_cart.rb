class CombineItemsInCart < ActiveRecord::Migration[5.0]
  def up
    #replace duplicate items in cart with increase in quantity
    Cart.all.each do |cart|
      #count the number of each product in cart
      sums = cart.line_items.group(:product_id).sum(:quantity)
      
      sums.each do |product_id, quantity|
        #remove individual items
        cart.line_items.where(product_id: product_id).delete_all
        
        #replace with a single item
        item = cart.line_items.build(product_id: product_id)
        item.quantity = quantity
        item.save!
      end
      
    end
  end
  
  def down
    #split items with quantity>1 into multiple items
    LineItem.where("quantity>1").each do |line_item|
      #add individual items
      line_item.quantity.times do
        LineItem.create(
            cart_id: line_item.cart_id,
            product_id: line_item.product,
            quantity: 1
          )
      end
      
      line_item.destroy
    end
  end
  
end
