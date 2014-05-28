class CreatePetTirednesses < ActiveRecord::Migration
  def change
    create_table :pet_tirednesses do |t|
      t.belongs_to :pet
      t.integer  :value
      t.datetime :last_interaction
      t.datetime :change

      t.timestamps
    end
  end
end
