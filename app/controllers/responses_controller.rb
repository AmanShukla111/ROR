class ResponsesController < ApplicationController
    def create
      @response = Response.new(response_params)
  
      if @response.save
        redirect_to form_path(@response.form), notice: "Response created successfully."
      else
        flash[:alert] = "Error saving response."
        redirect_back fallback_location: new_response_form_path(@response.form)
      end
    end
  
    def index
      if params[:form_id]
        @responses = Response.where(form_id: params[:form_id])
      else
        @responses = Response.all
      end
    end
  
    private
  
    def response_params
      params.require(:response).permit(:form_id, answers_attributes: [:form_field_id, :response_text])
    end
  end
  