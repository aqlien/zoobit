class AddBodyImageToPets < ActiveRecord::Migration
  def change
  	add_column :pets, :body_img, :string
  end
end
