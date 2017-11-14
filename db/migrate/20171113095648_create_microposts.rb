class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |t|
      t.text :content
      t.string :picture
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
