class AddDrinksAndSnacksToUser < ActiveRecord::Migration
  def up
    add_column :users, :drink_credits, :integer, default: 0
    add_column :users, :snack_credits, :integer, default: 0
  end

  def down
    remove_column :users, :drink_credits
    remove_column :users, :snack_credits
  end
end
