class AddAcceptedToGroups < ActiveRecord::Migration
  def change
    add_column :members, :accepted, :boolean, default: false, null: false
  end
end
