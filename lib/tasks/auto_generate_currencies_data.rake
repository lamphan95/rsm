namespace :company_data do
  desc "Auto generate currencies data"
  task generate_currencies_data: :environment do
    Company.all.each do |company|
      Currency.create! nation: "VietNam", unit: "VND", sign: "VND", company_id: company.id
      Currency.create! nation: "Japan", unit: "JPY", sign: "¥", company_id: company.id
      Currency.create! nation: "USA", unit: "USD", sign: "$", company_id: company.id
    end
  end
end
