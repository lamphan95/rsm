class Answer < ApplicationRecord
  acts_as_paranoid

  belongs_to :apply, required: true
  belongs_to :survey, required: true

  validates :name, presence: true, if: Proc.new { |answer|
    answer.survey_job.compulsory?
  }

  delegate :job, to: :survey, prefix: true, allow_nil: true

  scope :answers_of_surveys, ->id_apply{where(apply_id: id_apply)}
  scope :name_not_blank, ->{where.not(name: [nil, ""])}

end
