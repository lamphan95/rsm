class CreateSurveys < ActiveRecord::Migration[5.1]
  def change
    create_table :surveys do |t|
      t.references :question
      t.references :job
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
