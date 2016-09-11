class UploadsController < ApplicationController
  layout "dashboard" 

  before_filter :authenticate_user!

  def list
    @uploads = current_user.uploads.all
  end

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
    @upload = Upload.find(params[:id])
  end

  def crop_front
    @upload = Upload.find(params[:id])
    @upload.crop_front_image
    @upload.save!
  end

  def crop_back
    @upload = Upload.find(params[:id])
    @upload.crop_back_image
    @upload.save!
  end

  def crop_arm
    @upload = Upload.find(params[:id])
    @upload.crop_back_image
    @upload.save!
  end

  private
  def upload_params
    params.require(:upload).permit(:front_image, :back_image, :arm_image)
  end
end
