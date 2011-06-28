class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title, :null => false, :uniq => true, :default => ''

      t.timestamps
    end
  end
end
