require "rails_helper"

RSpec.describe Employers::JobsController, type: :controller do
  let!(:user) {FactoryGirl.create :user, confirmed_at: Time.current}
  let(:company) {FactoryGirl.create :company}
  let(:branch) {FactoryGirl.create :branch, company_id: company.id}
  let(:category) {FactoryGirl.create :category, company_id: company.id}
  let(:step) {FactoryGirl.create :step}
  let!(:company_step) {FactoryGirl.create :company_step, company_id: company.id, step_id: step.id}
  let!(:member) {FactoryGirl.create :member, company_id: company.id, user_id: user.id}
  let :job do
    FactoryGirl.create :job, company_id: company.id, branch_id: branch.id, category_id: category.id
  end
  subject {job}
  before { sign_in user }

  describe "DELETE #destroy" do
    before {request.host = "#{company.subdomain}.lvh.me:3000"}
    it "destroy job sucess" do
      delete :destroy, params: {id: subject.id},
        xhr: true, format: "js"
      expect(assigns[:message]).to match I18n.t("employers.jobs.destroy.success")
    end
  end

  describe "PATCH #update" do
    before {request.host = "#{company.subdomain}.lvh.me:3000"}
    it "update jobs success" do
      patch :update, params: { id: subject.id, job:{name: "Ruby on rails",
        description: "IT", min_salary: 500, position: "Manager", target: 10,
        survey_type: "not_exist", user_id: user.id, company_id: company.id,
        branch_id: branch.id, category_id: category.id}},
        xhr: true, format: "js"
      expect(assigns[:message]).to match I18n.t("employers.jobs.update.success")
    end

    it "update jobs fail" do
      patch :update, params: { id: subject.id, job:{name: ""}}, xhr: true, format: "js"
    end
  end

  describe "POST #create" do
    before {request.host = "#{company.subdomain}.lvh.me:3000"}
    it "create jobs success" do
      post :create, params: {job: {name: "Ruby on rails",
        description: "IT", min_salary: 500, position: "Manager", target: 10,
        survey_type: "not_exist", user_id: user.id, company_id: company.id,
        branch_id: branch.id, category_id: category.id}}, xhr: true, format: "js"
      expect(assigns[:message]).to match I18n.t("employers.jobs.create.success")
    end

    it "create jobs fail" do
      post :create, params: {job:{name: "Ruby on rails"}},
        xhr: true, format: "js"
    end
  end
end
