class RewardBenefit < ApplicationRecord
  acts_as_paranoid

  belongs_to :job

  validates :content, presence: true
end
