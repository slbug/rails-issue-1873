class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, :null => false, :default => ''
      t.belongs_to :brand
      t.belongs_to :category

      t.timestamps
    end
    add_index :products, :brand_id
    add_index :products, :category_id
  end
end
