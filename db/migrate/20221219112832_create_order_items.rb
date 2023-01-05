class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      
      t.integer :item_id
      t.integer :order_id
      t.integer :price
      t.integer :amount
      t.integer :is_production
      t.timestamps
    end
  end
end
