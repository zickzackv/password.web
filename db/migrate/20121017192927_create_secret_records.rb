class CreateSecretRecords < ActiveRecord::Migration
  def change
    create_table :secret_records do |t|
      t.string :username
      t.string :password
      t.string :url

      t.timestamps
    end
  end
end
