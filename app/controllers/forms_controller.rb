class FormsController < ApplicationController
    before_action :set_form, only: [ :new_response, :show, :edit, :update, :destroy, :responses ]

    # Display all forms
    def index
      @forms = Form.all
    end

    # Show a single form
    def show
    end

    # Initialize a new form
    def new
      @form = Form.new
    end

    # Create a form in the database
    def create
      @form = Form.new(form_params)
      if @form.save
        redirect_to @form, notice: "Form was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # Edit an existing form
    def edit
    end

    # Update a form in the database
    def update
      if @form.update(form_params)
        redirect_to @form, notice: "Form was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def responses
        # List all responses for this form
        @responses = @form.responses
    end


    def new_response
      @response = @form.responses.build
      @form.form_fields.each { |field| @response.answers.build(form_field: field) }
      puts Rails.root.join("app/views/forms/new_response.html.erb")
    end


    # Delete a form from the database
    def destroy
      @form.destroy
      redirect_to forms_path, notice: "Form was successfully deleted."
    end

    private

    # Set form for actions that need it
    def set_form
      @form = Form.find(params[:id])
    end

    # Strong parameters to allow specific form fields only
    def form_params
      params.require(:form).permit(:name, :description)
    end
end
