class CreateComments < ActiveRecord::Migration
  def change
  	create_table :comments do |t|  		
  		t.text :author
  		t.text :content
  		t.belongs_to :post, index: true  		

  		t.timestamps
  	end
  end
end
