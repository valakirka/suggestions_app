class Rating < ActiveRecord::Base
  belongs_to :suggestion
  belongs_to :user
end
