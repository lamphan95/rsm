namespace :company_data do
  desc "Auto generate job exception data"
  task generate_job_exception_data: :environment do
    Company.all.each do |company|
      Job.create!(
        description: "exception exception exception exception",
        name: "exception",
        level: "exception",
        company_id: company.id,
        user_id: 1,
        currency_id: Random.rand(1..3),
        min_salary: 500,
        language: "exception",
        branch_id: company.branches.first.id,
        category_id: company.categories.first.id,
        target: 10000,
        status: 2,
        position: "exception",
        survey_type: 0)
    end
  end
end
