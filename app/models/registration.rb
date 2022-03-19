class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  #validations
  validates :name, :surname, :age, :contact_no, presence: true
  validates :contact_no, length: {minimum: 4}

  # sanitise data with lifecycle hooks 
 before_save :remove_whitespace
 before_save :remove_hitler
 

 private 
 
 def remove_whitespace 
   self.name = self.name.strip
   self.surname = self.surname.strip
  
   

 end
 
 def remove_hitler 
   self.name = self.name.gsub(/hitler/i, "John")
   self.surname = self.surname.gsub(/hitler/i, "Smith")
 end


end
