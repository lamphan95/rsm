namespace :company_data do
  desc "Auto generate candidates data"
  task generate_candidates_data: :environment do
    Apply.all.each do |apply|
      candidate = Candidate.find_by email: apply.information[:email]
      if candidate.blank?
        Candidate.create! user_id: apply.user_id, company_id: apply.company_id,
          email: apply.information[:email], name: apply.information[:name],
          phone: apply.information[:phone], address: apply.information[:address],
          cv: File.new(Rails.root.join("lib", "seeds", "template_cv.pdf"))
      end
    end
  end
end
