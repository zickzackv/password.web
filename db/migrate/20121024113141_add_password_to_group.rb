class AddPasswordToGroup < ActiveRecord::Migration
  def change
    add_column :secret_records, :group_id, :integer
    g = Group.create! name: 'Default'
    User.all.each do |u|
      m = Member.new
      m.user_id = u.id
      m.group_id = g.id 
      m.secret = u.user_secret
      m.save!
    end
    SecretRecord.all.each do |sr|
      sr.group_id = g.id
      sr.save!
    end
  end
end
