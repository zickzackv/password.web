class Group < ActiveRecord::Base
  has_many :secret_records
  has_many :members
  has_many :users, through: :members
  attr_accessible :name

  def secret_for(user)
    member = member_for user
    return '' if member.nil?
    member.secret
  end

  def member_for(user)
    members.where(user_id: user.id).first
  end
end
