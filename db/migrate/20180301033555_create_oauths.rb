class CreateOauths < ActiveRecord::Migration[5.1]
  def change
    create_table :oauths do |t|
      t.references :user
      t.text :token
      t.text :refresh_token
      t.datetime :expires_at
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
