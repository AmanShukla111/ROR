class AddOwnerIdToForms < ActiveRecord::Migration[7.2]
  def change
    add_column :forms, :owner_id, :integer
  end
end
