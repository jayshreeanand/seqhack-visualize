class Upload < ActiveRecord::Base

  belongs_to :user

  mount_uploader :front_image, ImageUploader
  mount_uploader :back_image, ImageUploader
end
