# Controller for requests endpoint
class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Request.new(params.permit(request: :input_image)[:request])
    # TODO: add image to text and text to speech

    if @request.save
      redirect_to "/requests/#{@request.id}", notice: 'Successfully processed'
    else
      # TODO: render field specific errors in the view
      # TODO: ask Adi why we use render here
      render :new
    end
  end

  def show
    @request = Request.find(params[:id])
  end
end