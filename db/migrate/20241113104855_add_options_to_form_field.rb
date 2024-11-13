class AddOptionsToFormField < ActiveRecord::Migration[7.2]
  def change
    add_column :form_fields, :options, :text
  end
end
