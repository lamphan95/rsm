class CompanySetting < ApplicationRecord
  acts_as_paranoid

  belongs_to :company, optional: true
  serialize :enable_setting, Hash
end
