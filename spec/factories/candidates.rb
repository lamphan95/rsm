FactoryGirl.define do
  factory :candidate do
    association :user, factory: :user
    association :company, factory: :company
    name Faker::Name.name
    email Faker::Internet.email
    phone Faker::Number.number(10)
    cv File.new File.expand_path(Rails.root.join("lib", "seeds", "template_cv.pdf"))
  end
end
