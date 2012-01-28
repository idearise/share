class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
    	t.string :description, :limit => 32
  		t.string :file
  		t.references :app

  		t.timestamps
    end
  end
end
