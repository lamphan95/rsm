require "rails_helper"

RSpec.describe Note, type: :model do
  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :apply}
  end

  context "column" do
    it {is_expected.to have_db_column(:content).of_type(:text)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :content}
  end
end
