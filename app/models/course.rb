class Course < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :user
end
