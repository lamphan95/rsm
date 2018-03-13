FactoryGirl.define do
  factory :currency do
    nation "VietNam"
    unit "VND"
    sign "Đồng"
    association :company, factory: :company
  end
end
