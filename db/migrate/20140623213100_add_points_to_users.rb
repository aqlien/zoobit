class AddPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :points, :integer, default: 0
    add_column :users, :pet_slots, :integer, default: 1
  end
end
