class CreateSpecifications < ActiveRecord::Migration
  def change
    create_table :specifications do |t|
      t.belongs_to :product, :null => false
      t.belongs_to :attribute, :null => false
      t.belongs_to :specification, :default => nil
      t.string :format, :default => nil

      t.timestamps
    end
    add_index :specifications, :product_id
    add_index :specifications, :attribute_id
    add_index :specifications, :specification_id
  end
end
