class ProjectMember < ApplicationRecord
  acts_as_paranoid

  belongs_to :member
  belongs_to :project
end
