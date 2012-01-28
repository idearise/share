class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.string :website
      t.text :about
      t.text :thanks_to
      t.string :twitter
      t.string :facebook
      t.string :google_plus
      t.string :android
      t.string :itunes
      t.references :user

      t.integer :created_by
      t.string :created_ip, :limit => 39
      t.integer :updated_by
      t.string :updated_ip, :limit => 39

      t.timestamps
    end

    add_index :apps, :created_by
    add_index :apps, :created_at
    add_index :apps, :updated_by
    add_index :apps, :updated_at
  end
end
