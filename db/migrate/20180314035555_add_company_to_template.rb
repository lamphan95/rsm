class AddCompanyToTemplate < ActiveRecord::Migration[5.1]
  def change
    add_reference :templates, :company, foreign_key: true
  end
end
