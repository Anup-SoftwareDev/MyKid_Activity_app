class Activity < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_one_attached :picture
  has_many :registrations

  #validations
  validates :title, :description, :price, :category, presence: true
  validates :title, length: {minimum: 4}
  #validates :price, format: { with: /\A\d+\z/, message: "Integer only. No sign allowed." }

 # sanitise data with lifecycle hooks 
 before_save :remove_whitespace
 before_save :remove_hate
 before_validation :convert_price_to_cents, if: :price_changed?

 private 
 
 def remove_whitespace 
   self.title = self.title.strip
   self.description = self.description.strip
 end
 
 def remove_hate 
   self.title = self.title.gsub(/hate/i, "love")
   self.description = self.description.gsub(/hate/i, "love")
 end
 
 def convert_price_to_cents 
   self.price = (self.attributes_before_type_cast["price"].to_f * 100).round
 end 



end
