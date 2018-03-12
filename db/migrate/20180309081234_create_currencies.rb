class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.string :nation
      t.string :unit
      t.text :sign
      t.references :company
      t.date :deleted_at

      t.timestamps
    end
  end
end
