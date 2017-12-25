require "rails_helper"

RSpec.describe Appointment, type: :model do
  context "associations" do
    it {should belong_to :apply}
    it {should belong_to :company}
    it {is_expected.to have_many :inforappointments}

  end

  context "columns" do
    it {should have_db_column(:address).of_type(:text)}
    it {should have_db_column(:start_time).of_type(:datetime)}
    it {should have_db_column(:end_time).of_type(:datetime)}
    it {should have_db_column(:apply_id).of_type(:integer)}
    it {should have_db_column(:company_id).of_type(:integer)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of(:start_time)}
    it {is_expected.to validate_presence_of(:end_time)}
    it {is_expected.to validate_presence_of(:address)}
  end
end
