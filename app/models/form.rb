class Form < ApplicationRecord
    belongs_to :owner, class_name: "User", foreign_key: :owner_id

    has_many :form_fields, dependent: :destroy
    has_many :responses, dependent: :destroy
    has_many :form_invites, dependent: :destroy
    has_many :invited_users, through: :form_invites, source: :user

    # Check if a user has a specific role
    def user_role(user)
        form_invites.find_by(user: user)&.role
    end
end
