class AddLastUpdateToPets < ActiveRecord::Migration
  def change
    add_column :pets, :last_update, :datetime
  end
end
