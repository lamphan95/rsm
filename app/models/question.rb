class Question < ApplicationRecord
  belongs_to :company

  has_many :surveys

  validates :name, presence: true
end
