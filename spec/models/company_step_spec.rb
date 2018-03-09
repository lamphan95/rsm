require "rails_helper"

RSpec.describe CompanyStep, type: :model do
  context "associations" do
    it {is_expected.to belong_to :company}
    it {is_expected.to belong_to :step}
  end

  context "columns" do
    it {is_expected.to have_db_column(:priority).of_type :integer}
    it {is_expected.to have_db_column(:deleted_at).of_type :datetime}
  end
end
