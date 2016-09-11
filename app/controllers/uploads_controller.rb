class UploadsController < ApplicationController
  layout "dashboard" 

  before_filter :authenticate_user!

  def new
    @upload = Upload.new(user: current_user)
  end

  def create
     @upload = Upload.new(upload_params)
    if @upload.save
      redirect_to @upload
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      render "new"
    end
  end

  def show
    @uploads = current_user.uploads.all
  end

  private
  def upload_params
    params.require(:upload).permit(:front_image, :back_image, :arm_image)
  end
end
