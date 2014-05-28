class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.string :type
      t.string :breed
      t.string :gender
      t.integer :happiness
      t.string :img_loc
      t.references :user, index: true
      t.timestamps
    end
  end
end
