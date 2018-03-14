class CompanyActivity < ApplicationRecord
  acts_as_paranoid

  belongs_to :company

  validates :title, presence: true
  mount_uploader :picture, ActivityPictureUploader
end
