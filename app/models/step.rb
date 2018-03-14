class Step < ApplicationRecord
  acts_as_paranoid

  has_many :status_steps, dependent: :destroy
  has_many :company_steps, dependent: :destroy

  def is_step? code
    self.name.include? code
  end
end
