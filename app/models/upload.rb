class Upload < ActiveRecord::Base

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  belongs_to :user

  serialize :front_image_details
  serialize :back_image_details
  serialize :arm_image_details
  
  mount_uploader :front_image, ImageUploader
  mount_uploader :back_image, ImageUploader
  mount_uploader :arm_image, ImageUploader

end
