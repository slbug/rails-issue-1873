class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.decimal :value, :null => false, :default => 0
      t.belongs_to :specification, :null => false
      t.string :unit, :null => false, :default => ''

      t.timestamps
    end
    add_index :measurements, :specification_id
  end
end
