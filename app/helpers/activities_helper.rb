module ActivitiesHelper

        def format_category(category)
          #capitalizes every word in string
          category.split(" ").map {|word| word.capitalize}.join(" ")
        end 
      
        def format_price(price)
          "$#{price/ 100.0}"
        end 
      

end
