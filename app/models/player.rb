class Player < ActiveRecord::Base
  has_one :draft
  has_one :user, through: :draft

end
