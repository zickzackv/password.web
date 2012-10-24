class Member < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  attr_accessible :user_id

  def password
  end
end
