class AddCurrencyToJobs < ActiveRecord::Migration[5.1]
  def change
    add_reference :jobs, :currency, foreign_key: true
  end
end
