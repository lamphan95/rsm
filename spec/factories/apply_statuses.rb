FactoryGirl.define do
  factory :apply_status do
    association :apply, factory: :apply
    association :status_step, factory: :status_step
  end
end
