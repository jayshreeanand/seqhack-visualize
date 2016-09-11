class UploadsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @upload = Upload.new(user: current_user)
  end

  def show
    @uploads = current_user.uploads.all
  end
end
