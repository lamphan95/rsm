class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.text :content
      t.references :apply
      t.references :user
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
