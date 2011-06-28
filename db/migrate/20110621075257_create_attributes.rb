class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :title, :null => false, :default => ''
      t.string :attribute_type, :null => false, :default => 'Trait'
      t.belongs_to :group, :null => false

      t.timestamps
    end
    add_index :attributes, :group_id
  end
end
