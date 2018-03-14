class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.integer :type
      t.datetime :deleted_at

      t.index [:follower_id, :followed_id], unique: true

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
  end
end
