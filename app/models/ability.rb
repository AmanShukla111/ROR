class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    # Form Owner Permissions
    # The owner can manage the form, including inviting users and revoking invitations.
    can :manage, Form, owner_id: user.id
    can :manage, FormInvite, form: { owner_id: user.id } # Owners can manage invites for their forms.

    # Editor Permissions
    # Editors can view and update the form, as well as view responses.
    can [:read, :update, :responses], Form, form_invites: { user_id: user.id, role: 'editor' }

    # Viewer Permissions
    # Viewers can only read the form and its responses.
    can [:read, :responses], Form, form_invites: { user_id: user.id, role: 'viewer' }

    # Default Permissions
    # Prevents invited users from managing forms or invites if they're not the owner.
    cannot :manage, Form unless can?(:manage, Form)
  end
end
