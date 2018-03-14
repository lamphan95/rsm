class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :name
      t.references :company
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
