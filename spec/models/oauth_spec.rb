require "rails_helper"

RSpec.describe Oauth, type: :model do
  context "associations" do
    it {is_expected.to belong_to :user}
  end

  context "column" do
    it {is_expected.to have_db_column(:token).of_type :text}
    it {is_expected.to have_db_column(:refresh_token).of_type :text}
    it {is_expected.to have_db_column(:expires_at).of_type :datetime}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :token}
    it {is_expected.to validate_presence_of :refresh_token}
    it {is_expected.to validate_presence_of :expires_at}
  end
end
