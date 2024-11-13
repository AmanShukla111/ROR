class Form < ApplicationRecord
    has_many :form_fields
    has_many :responses, dependent: :destroy
end
