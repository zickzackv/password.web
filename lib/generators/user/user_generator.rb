class UserGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  def create_user
    new_email = ask('New user e-mail:').strip
    new_password = ask('New user password:').strip

    if User.count == 0
      secret = rand(512**36).to_s(36)
    else
      curr_email = ask('Current users e-mail:').strip
      curr_password = ask('Current users password:').strip
      user = User.find_by_email(curr_email)
      raise "Current passwort doesn't match" unless user.valid_password?(curr_password)
      secret = user.user_secret
      secret = `echo '#{secret}' | openssl enc -aes-256-cbc -pass pass:"#{curr_password}" -d -base64`.strip
    end
    
    encrypted = `echo '#{secret}' | openssl enc -aes-256-cbc -pass pass:"#{new_password}" -e -base64`.strip

    user = User.new(
      email: new_email,
      password: new_password,
      password_confirmation: new_password,
    )
    user.user_secret = encrypted
    user.save! unless encrypted.blank?
  end
end
