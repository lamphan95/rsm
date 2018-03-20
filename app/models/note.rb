class Note < ApplicationRecord
  acts_as_paranoid

  belongs_to :apply
  belongs_to :user

  validates :content, presence: true

  delegate :name, to: :user, prefix: true, allow_nil: true

  scope :get_newest, ->{order created_at: :desc}
end
