class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :form_invites, dependent: :destroy
  has_many :invited_forms, through: :form_invites, source: :form
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
