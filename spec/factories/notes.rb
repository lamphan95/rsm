FactoryGirl.define do
  factory :note do
    content Faker::Lorem.paragraph
    association :user, factory: :user
    association :apply, factory: :apply
  end
end
