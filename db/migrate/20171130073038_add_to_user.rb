class AddToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :picture, :text
  end
end
