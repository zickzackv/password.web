class AddFieldsToSecretRecords < ActiveRecord::Migration
  def change
    add_column :secret_records, :title, :string
    add_column :secret_records, :notes, :text
  end
end
