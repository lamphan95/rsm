class Oauth < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  validates :token, presence: true
  validates :refresh_token, presence: true
  validates :expires_at, presence: true

  scope :get_newest, ->{where order created_at: :desc}

  def to_params
    {refresh_token: self.refresh_token,
    client_id: ENV["GOOGLE_OAUTH2_APP_ID"],
    client_secret: ENV["GOOGLE_OAUTH2_APP_SECRET"],
    grant_type: "refresh_token"}
  end

  def request_token_from_google
    url = URI "https://accounts.google.com/o/oauth2/token"
    Net::HTTP.post_form url, self.to_params
  end

  def refresh
    data = JSON.parse request_token_from_google.body
    update_attributes token: data["access_token"],
      expires_at: Time.now.utc + data["expires_in"].to_i.seconds
  end

  def check_access_token
    self.refresh if self.expires_at < Time.now.utc
  end
end
