class Activity < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_one_attached :picture
  has_many :registrations

  #validations
  validates :title, :description, :price, :category, presence: true
  validates :title, length: {minimum: 4}
  #validates :price, format: { with: /\A\d+\z/, message: "Integer only. No sign allowed." }
end
