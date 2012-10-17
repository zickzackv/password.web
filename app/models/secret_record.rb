class SecretRecord < ActiveRecord::Base
  attr_accessible :password, :url, :username
end
