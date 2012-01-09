class CreateClientPlatforms < ActiveRecord::Migration
  def change
    create_table :client_platforms do |t|
      t.references :platform
      t.references :app

      t.timestamps
    end

    add_index :client_platforms, :created_at
    add_index :client_platforms, :updated_at    
  end
end
