class FormInvitesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_form
    before_action :authorize_owner, only: [:create, :index]
  
    def create
      @user = User.find_or_create_by(email: params[:email])
      @invite = @form.form_invites.find_or_initialize_by(user: @user)
  
      if @invite.update(role: params[:role])
        # Optionally send an email using ActionMailer
        FormInviteMailer.invitation_email(@invite).deliver_later if defined?(FormInviteMailer)
  
        render json: { message: "Invitation sent successfully." }, status: :ok
      else
        render json: { errors: @invite.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def accept
      @invite = FormInvite.find_by(token: params[:token], user: current_user)
  
      if @invite&.update(accepted: true)
        redirect_to forms_path, notice: "You have accepted the invitation."
      else
        redirect_to root_path, alert: "Invalid or expired invitation."
      end
    end
  
    def index
      @invites = @form.form_invites
    end

    def destroy
      invite = FormInvite.find(params[:id])
      authorize! :manage, invite
      invite.destroy
      redirect_to form_path(invite.form), notice: "Invitation revoked."
    end

    def revoke
      @form = Form.find(params[:form_id])  # Find the form
      @form_invite = @form.form_invites.find(params[:id])  # Find the specific invite
  
      if @form_invite.destroy
        flash[:notice] = "Invitation revoked successfully."
      else
        flash[:alert] = "There was an issue revoking the invitation."
      end
  
      redirect_to @form  # Redirect back to the form's show page
    end
  
    private
  
    def set_form
      @form = Form.find(params[:form_id])
    end
  
    def authorize_owner
      redirect_to root_path, alert: "You are not authorized." unless @form.owner == current_user
    end
  end
  