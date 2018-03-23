class CreateCandidates < ActiveRecord::Migration[5.1]
  def change
    create_table :candidates do |t|
      t.references :user
      t.references :company
      t.string :email
      t.string :phone
      t.string :name
      t.text :address
      t.integer :employer_id
      t.text :cv
      t.integer :user_created

      t.timestamps
    end
  end
end
