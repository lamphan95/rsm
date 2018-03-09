require "rails_helper"

RSpec.describe StatusStep, type: :model do
  context "associations" do
    it {is_expected.to belong_to :step}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:deleted_at).of_type :datetime}
    it {is_expected.to have_db_column(:code).of_type :string}
  end
end
