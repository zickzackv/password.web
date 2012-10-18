class SecretRecord < ActiveRecord::Base
  attr_accessible :password, :url, :username, :title, :notes

  def password=(value)
    super unless value.blank?
  end
end
