class CreateFormInvites < ActiveRecord::Migration[7.2]
  def change
    create_table :form_invites do |t|
      t.references :form, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role, null: false, default: 0
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end