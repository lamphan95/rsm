require "rails_helper"

RSpec.describe Candidate, type: :model do
  let(:company) {FactoryGirl.create :company}
  let(:user) {FactoryGirl.create :user}
  let(:candidate) {FactoryGirl.create :candidate, user_id: user.id, company_id: company.id}

  subject {candidate}

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :company}
  end

  context "column" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:email).of_type(:string)}
    it {is_expected.to have_db_column(:phone).of_type(:string)}
    it {is_expected.to have_db_column(:address).of_type(:text)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_column(:company_id).of_type(:integer)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_presence_of :phone}
    it {is_expected.to validate_presence_of :cv}
  end

  context "when name is too short" do
    before {subject.name = "a"}
    it "matches the error message" do
      subject.valid?
      subject.errors[:name].present?
    end
  end

  context "when email invalid" do
    before {subject.email = "user"}
    it "matches the error message" do
      subject.valid?
      subject.errors[:email].present?
    end
  end

  context "when phone invalid" do
    before {subject.phone = "mot ha ba"}
    it "matches the error message" do
      subject.valid?
      subject.errors[:phone].present?
    end
  end
end
