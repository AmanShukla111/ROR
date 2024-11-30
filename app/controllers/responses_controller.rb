class ResponsesController < ApplicationController
  before_action :set_form, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  before_action :set_response, only: [:show, :edit, :update, :destroy]

  def index
    @responses = @form.responses
  end

  def show
    # Set @form based on @response's associated form
    @form = @response.form
  end

  def edit
    @form = Form.find(params[:form_id])
    @response = @form.responses.find(params[:id])
  end

  def update
    if @response.update(response_params)
      redirect_to form_response_path(@form, @response), notice: 'Response was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @response.destroy
    redirect_to form_responses_path(@form), notice: 'Response was successfully deleted.'
  end

  def new
    @response = @form.responses.build
    @form.form_fields.each do |field|
      @response.answers.build(form_field: field)
    end
  end

  def create
    @response = @form.responses.build(response_params)
    if @response.save
      redirect_to form_path(@form), notice: 'Response was successfully submitted.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_form
    @form = Form.find(params[:form_id])
  end

  def set_response
    @response = Response.find(params[:id])
  end

  def response_params
    params.require(:response).permit(answers_attributes: [:id, :response_text, :form_field_id])
  end
end
