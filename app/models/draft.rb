class Draft < ActiveRecord::Base
  belongs_to :player
  belongs_to :user

end
