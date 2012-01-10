class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :limit => 64
      t.string :email, :limit => 255
      t.string :avatar, :limit => 64
      t.string :nickname, :limit => 32
      t.string :website, :limit => 64
      t.string :twitter, :limit => 32
      t.string :linkedin, :limit => 64
      t.string :facebook, :limit => 64
      t.string :google, :limit => 64
      t.text :about
      t.string :last_ip, :limit => 39
      t.integer :created_by
      t.string :created_ip, :limit => 39
      t.integer :updated_by
      t.string :updated_ip, :limit => 39   

      t.timestamps
    end
    
    add_index :users, [:created_by,:updated_by]
    add_index :users, :last_ip
  end
end