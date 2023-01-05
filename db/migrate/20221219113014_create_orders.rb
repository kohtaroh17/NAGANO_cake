class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      
      
      t.integer :customer_id
      t.integer :postage
      t.integer :total_price
      t.integer :payment_method
      t.string :name
      t.string :address
      t.string :postal_code
      t.integer :st_order
      t.timestamps
    end
  end
end
