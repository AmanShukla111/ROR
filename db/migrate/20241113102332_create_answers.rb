class CreateAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :answers do |t|
      t.references :response, null: false, foreign_key: true
      t.references :form_field, null: false, foreign_key: true
      t.string :response_text

      t.timestamps
    end
  end
end
