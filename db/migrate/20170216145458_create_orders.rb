class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :entity
      t.string :supplier
      t.string :order_number
      t.string :order_date
      t.string :designation
      t.string :total_price
      t.string :order_signatory
      t.string :delivery_scheduled
      t.integer :user_id
      t.timestamps
    end
  end
end
