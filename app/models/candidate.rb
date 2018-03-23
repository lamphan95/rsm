class Candidate < ApplicationRecord
  belongs_to :company
  belongs_to :user, optional: true

  mount_uploader :cv, CvUploader

  validates :cv, presence: true
  validates :name, presence: true, length: {maximum: Settings.apply.model.name_max_length,
    minimum: Settings.apply.model.name_min_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
  validates :phone, presence: true, length: {maximum: Settings.apply.model.phone_max_length,
    minimum: Settings.apply.model.phone_min_length}, numericality: true
end
