class FormField < ApplicationRecord
  belongs_to :form
  has_many :answers, dependent: :destroy
  #has_many :options, dependent: :destroy
  serialize(:options,coder:JSON)
end
