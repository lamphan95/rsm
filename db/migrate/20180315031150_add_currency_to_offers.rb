class AddCurrencyToOffers < ActiveRecord::Migration[5.1]
  def change
    add_reference :offers, :currency, foreign_key: true
  end
end
