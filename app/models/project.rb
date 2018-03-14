class Project < ApplicationRecord
  acts_as_paranoid

  belongs_to :company
  has_many :project_members, dependent: :destroy
end
