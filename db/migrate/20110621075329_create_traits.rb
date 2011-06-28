class CreateTraits < ActiveRecord::Migration
  def change
    create_table :traits do |t|
      t.string :value, :null => false, :default => ''
      t.belongs_to :specification, :null => false

      t.timestamps
    end
    add_index :traits, :specification_id
  end
end
