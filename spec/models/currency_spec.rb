require "rails_helper"

RSpec.describe Currency, type: :model do
  context "associations" do
    it {is_expected.to have_many :jobs}
    it {is_expected.to have_many :offers}
    it {is_expected.to belong_to :company}
  end

  context "columns" do
    it {is_expected.to have_db_column(:nation).of_type :string}
    it {is_expected.to have_db_column(:unit).of_type :string}
    it {is_expected.to have_db_column(:sign).of_type :text}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :nation}
    it {is_expected.to validate_presence_of :unit}
    it {is_expected.to validate_presence_of :sign}
  end
end
