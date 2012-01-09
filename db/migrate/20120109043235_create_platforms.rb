class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.string :name
      t.integer :display_order, :default => 1

      t.timestamps
    end
  end
end
