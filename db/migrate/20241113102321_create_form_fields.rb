class CreateFormFields < ActiveRecord::Migration[7.2]
  def change
    create_table :form_fields do |t|
      t.references :form, null: false, foreign_key: true
      t.text :field_text
      t.integer :field_type

      t.timestamps
    end
  end
end
