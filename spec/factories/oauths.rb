FactoryGirl.define do
  factory :oauth do
    association :user, factory: :user
    token {Faker::Code.isbn}
    refresh_token {Faker::Code.isbn}
    expires_at {Faker::Date.forward(23)}
  end
end
