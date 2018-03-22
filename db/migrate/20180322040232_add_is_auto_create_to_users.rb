class AddIsAutoCreateToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :auto_password, :string
  end
end
