class CreateBoolTraits < ActiveRecord::Migration
  def change
    create_table :bool_traits do |t|
      t.boolean :value, :null => false, :default => true
      t.belongs_to :specification, :null => false

      t.timestamps
    end
    add_index :bool_traits, :specification_id
  end
end
