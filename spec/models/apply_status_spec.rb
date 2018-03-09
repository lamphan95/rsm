require "rails_helper"

RSpec.describe ApplyStatus, type: :model do
  context "associations" do
    it {is_expected.to belong_to :apply}
    it {is_expected.to belong_to :status_step}
  end

  context "columns" do
    it {is_expected.to have_db_column(:content_email).of_type :text}
    it {is_expected.to have_db_column(:is_current).of_type :integer}
  end
end
