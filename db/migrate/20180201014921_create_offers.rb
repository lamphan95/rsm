class CreateOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.references :user
      t.references :apply_status
      t.references :currency
      t.float :salary
      t.date :start_time
      t.text :address
      t.text :requirement
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
