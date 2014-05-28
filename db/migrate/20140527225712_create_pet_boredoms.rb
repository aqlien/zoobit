class CreatePetBoredoms < ActiveRecord::Migration
  def change
    create_table :pet_boredoms do |t|
      t.integer  :pet_id
      t.integer  :value
      t.datetime :last_interaction
      t.datetime :change

      t.timestamps
    end
  end
end
