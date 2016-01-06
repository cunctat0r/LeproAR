class CreateComments < ActiveRecord::Migration
  def change
  	create_table :comments do |t|
  		t.text :author
  		t.text :content

  		t.timestamps
  	end
  end
end
