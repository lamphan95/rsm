require "rails_helper"

RSpec.describe Step, type: :model do
  context "associations" do
    it {is_expected.to have_many :status_steps}
    it {is_expected.to have_many :company_steps}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:deleted_at).of_type :datetime}
    it {is_expected.to have_db_column(:description).of_type :string}
  end
end
