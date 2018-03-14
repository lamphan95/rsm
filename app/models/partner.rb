class Partner < ApplicationRecord
  acts_as_paranoid

  belongs_to :company

  validates :name, presence: true
  validates :email, presence: true
  mount_uploader :picture, PartnerPictureUploader
end
