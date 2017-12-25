require "rails_helper"

RSpec.describe AchievementsController, type: :controller do
  let(:achievement) {FactoryGirl.create :achievement}
  let(:user) {FactoryGirl.create :user}
  subject {achievement}
  before {sign_in user}

  describe "GET #new" do
    before :each do
      get :new, xhr: true
    end
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "create achievement success" do
      post :create, params: {achievement: {name: "phamd1ucpho", majors: "CNTT",
        organization: "Da Nang city", received_time: "01/02/2017", user_id: user.id}},
          xhr: true, format: "js"
      expect(response).to be_success
      expect(assigns[:message]).to match I18n. t("achievements.create_success")
    end

    it "create achievement fail" do
      post :create, params: {id: subject.id, achievement:{name: "", majors: "CNTT"}},
        xhr: true, format: "js"
      expect(assigns[:message]).not_to match I18n. t("achievements.create_success")
    end
  end
end
