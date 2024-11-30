class FormInvite < ApplicationRecord
  belongs_to :form
  belongs_to :user

  enum role: { viewer: 0, editor: 1 }
end
