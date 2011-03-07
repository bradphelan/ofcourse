class Role < ActiveRecord::Base
   has_many :users

   def to_s
     name
   end

   # Allow equality 
   def ==(other)
     to_s == other.to_s
   end
end
