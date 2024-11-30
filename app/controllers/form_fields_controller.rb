class FormFieldsController < ApplicationController
    before_action :set_form
    before_action :set_form_field, only: [:update, :edit, :destroy]
  
    def new
      @form_field = @form.form_fields.new
    end

    def edit
    end

    def create
      @form = Form.find(params[:form_id])
      @form_field = @form.form_fields.new(form_field_params)
  
      if @form_field.save
        redirect_to edit_form_path(@form), notice: "Question added successfully."
      else
        redirect_to edit_form_path(@form), alert: "Failed to add the question."
      end
    end
  
    def update
      if @form_field.update(form_field_params)
        redirect_to edit_form_path(@form_field.form), notice: "Question updated successfully."
      else
        redirect_to edit_form_path(@form_field.form), alert: "Failed to update the question."
      end
    end
  
    def destroy
      @form = @form_field.form
      @form_field.destroy
      redirect_to edit_form_path(@form), notice: "Question deleted successfully."
    end
  
    private
    
    def set_form
      @form = Form.find(params[:form_id])
    end

    def set_form_field
      @form_field = FormField.find(params[:id])
    end
  
    def form_field_params
      params.require(:form_field).permit(:field_text, :options)
    end
  end
  