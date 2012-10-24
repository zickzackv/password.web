class User < ActiveRecord::Base
  rolify

  has_many :members
  has_many :groups, through: :members

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :update_password
  
  def valid_password?(value)
    @current_password = value
    super
  end

  def update_password=(value)
    return if value.blank?
    raise "Could not change password" if @current_password.blank?
    update_user_secret(@current_password, value)
    self.password = value
  end

  def update_password

  end

  def update_user_secret(current_password, new_password)
    secret = `echo '#{self.user_secret}' | openssl enc -aes-256-cbc -pass pass:'#{current_password.shellescape}' -d -base64`.strip
    self.user_secret = `echo '#{secret}' | openssl enc -aes-256-cbc -pass pass:'#{new_password.shellescape}' -e -base64`.strip
  end
end
