class Answer < ApplicationRecord
  belongs_to :response
  belongs_to :form_field
end
