FactoryGirl.define do
  factory :status_step do
    association :step, factory: :step
  end
end
