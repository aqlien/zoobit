class AddStoriesToPets < ActiveRecord::Migration
  def change
    add_column :pets, :story, :text
  end
end
