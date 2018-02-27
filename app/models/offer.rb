class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :apply_status

  validates :salary, presence: true
  validates :start_time, presence: true
  validates :address, presence: true

  delegate :name, to: :user, prefix: true, allow_nil: true

  scope :get_newest, ->{order created_at: :desc}
end
