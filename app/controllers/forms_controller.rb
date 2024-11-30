class FormsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource


  # Display all forms
  def index
    @forms = Form.all
  end


  def show
    # If the user is not authorized, set the flash notice and redirect
    if cannot?(:read, @form)
      flash[:notice] = "You are not authorized to access this form."
      redirect_to forms_path and return
    end
  end


  # Initialize a new form
  def new
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)
    @form.owner_id = current_user.id 

    if @form.save
      redirect_to @form, notice: "Form was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Edit a form
  def edit
    @form_fields = @form.form_fields
  end

  # Update a form in the database
  def update
    if @form.update(form_params)
      redirect_to @form, notice: "Form was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # List all responses for this form
  def responses
    @responses = @form.responses
  end

  # Delete a form
  def destroy
    if @form.destroy
      redirect_to forms_path, notice: "Form was successfully deleted."
    else
      redirect_to @form, alert: "Unable to delete the form."
    end
  end

  def invite_user
    form = Form.find(params[:id])
    authorize! :invite, form
  
    email = params[:email]
    role = params[:role]
    user = User.find_or_create_by(email: email)
    
    invite = form.form_invites.find_or_initialize_by(user: user)
    invite.role = role
    invite.accepted = false
    if invite.save
      # (Optional) Send an email with the invitation link.
      redirect_to form_path(form), notice: "Invitation sent to #{email}."
    else
      redirect_to form_path(form), alert: "Unable to send invitation."
    end
  end


  def revoke_invite
    @form = Form.find(params[:id])
    @form_invite = @form.form_invites.find(params[:invite_id])
    
    if @form_invite.destroy
      flash[:notice] = "Invitation revoked successfully."
    else
      flash[:alert] = "There was an issue revoking the invitation."
    end

    redirect_to @form
  end
  

  private

  # Strong parameters to allow specific form fields only
  def form_params
    params.require(:form).permit(:name, :description)
  end
end
