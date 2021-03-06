require "rails_helper"

RSpec.describe Apply, type: :model do
  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :job}
    it {is_expected.to have_one :company}
    it {is_expected.to have_many :inforappointments}
    it {is_expected.to have_many :apply_statuses}
    it {is_expected.to have_many :appointments}
    it {is_expected.to have_many :status_steps}
    it {is_expected.to have_many :steps}
    it {is_expected.to have_many :offers}
  end

   context "columns" do
    it {is_expected.to have_db_column(:status).of_type(:integer)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_column(:job_id).of_type(:integer)}
    it {is_expected.to have_db_column(:cv).of_type(:text)}
    it {is_expected.to have_db_column(:information).of_type(:text)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of(:cv)}
    it {is_expected.to validate_presence_of(:information)}
  end

  context "nested attributes for apply_statuses" do
    it "exits accept_nested_attributes_for apply_statuses " do
      expect accept_nested_attributes_for(:apply_statuses)
      expect accept_nested_attributes_for(:apply_statuses).allow_destroy(true)
      expect accept_nested_attributes_for(:apply_statuses).update_only(true)
    end
  end

  context "nested attributes for answers" do
    it "exits accept_nested_attributes_for answers " do
      expect accept_nested_attributes_for(:answers)
      expect accept_nested_attributes_for(:answers).allow_destroy(true)
    end
  end

  context "delegate to job" do
    it "exits delegate_method name to job " do
      expect delegate_method(:name).to(:job)
      expect delegate_method(:name).to(:job).with_prefix(true)
    end
  end

  context "delegate to step" do
    it "exits delegate_method name to step " do
      expect delegate_method(:name).to(:step)
      expect delegate_method(:name).to(:step).with_prefix(true)
    end
  end

  context "delegate to user" do
    it "exits delegate_method name to user " do
      expect delegate_method(:name).to(:user)
      expect delegate_method(:name).to(:user).with_prefix(true)
    end

    it "exits delegate_method email to user " do
      expect delegate_method(:email).to(:user)
      expect delegate_method(:email).to(:user).with_prefix(true)
    end

    it "exits delegate_method phone to user " do
      expect delegate_method(:phone).to(:user)
      expect delegate_method(:phone).to(:user).with_prefix(true)
    end
  end
end
