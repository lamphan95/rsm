class Template < ApplicationRecord
  belongs_to :user
  belongs_to :company

  validates :name, presence: true, uniqueness: true
  validates :title, presence: true
  validates :type_of, presence: true

  enum type_of: [:template_member, :template_user]

  scope :get_newest, ->{order created_at: :desc}
end
