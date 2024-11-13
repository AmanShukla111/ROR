class Response < ApplicationRecord
  belongs_to :form
  has_many :answers, dependent: :destroy
end
