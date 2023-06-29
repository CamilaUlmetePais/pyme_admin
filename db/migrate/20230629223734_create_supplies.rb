class CreateSupplies < ActiveRecord::Migration[7.0]
  def change
    create_table :supplies do |t|
      t.string :name
      t.float :price
      t.integer :unit
      t.float :stock
      t.timestamps
    end
  end
end
