class AddEnergyToPets < ActiveRecord::Migration
  def change
    add_column :pets, :last_rest, :datetime
    add_column :pets, :last_feeding, :datetime
    add_column :pets, :energy, :integer
    add_column :pets, :fullness, :integer
  end
end
