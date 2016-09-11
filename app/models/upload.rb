require 'open-uri'

class Upload < ActiveRecord::Base

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  belongs_to :user

  serialize :front_image_details
  serialize :back_image_details
  serialize :arm_image_details
  
  mount_uploader :front_image, ImageUploader
  mount_uploader :back_image, ImageUploader
  mount_uploader :arm_image, ImageUploader
  mount_uploader :generated_texture, ImageUploader

  
  def texture_background
    Rails.root.join("app", "assets", "images", "texture_background.jpg")
  end
  
  def final_texture
    Rails.root.join("tmp", "#{self.id}_Asian_Male.jpg")
  end
  
  def resized_front_image
    Rails.root.join("tmp", "#{self.id}_front.png")
  end
  
  def resized_back_image
    Rails.root.join("tmp", "#{self.id}_back.png")
  end
  
  def resized_arm_image
    Rails.root.join("tmp", "#{self.id}_arm.png")
  end
  
  def resized_back_left
    Rails.root.join("tmp", "#{self.id}_back_left.png")
  end
  
  def resized_back_right
    Rails.root.join("tmp", "#{self.id}_back_right.png")
  end
  
  def download_images
    if Rails.env.development?
      FileUtils.copy(front_image.file.path, resized_front_image) if front_image.file.present?
      FileUtils.copy(back_image.file.path, resized_back_image) if back_image.file.present?
      FileUtils.copy(arm_image.file.path, resized_arm_image) if arm_image.file.present?
    else
      open(resized_front_image, 'wb') do |file|
        file << open(front_image.url).read
      end
      open(resized_back_image, 'wb') do |file|
        file << open(back_image.url).read
      end
      open(resized_arm_image, 'wb') do |file|
        file << open(arm_image.url).read
      end
    end
  end
  
  def generate_texture
    download_images

    final = Magick::Image.read(texture_background)[0]
    
    # Upload front side
    front = Magick::Image.read(resized_front_image)[0]
    front.resize_to_fill!(280, 325)
    
    final = base_texture.composite(front, Magick::NorthWestGravity, 125, 30, Magick::OverCompositeOp)

    # add first arm
    arm = Magick::Image.read(resized_arm_image)[0]
    arm.resize_to_fill!(260, 180)
    
    final = final.composite(arm, Magick::NorthWestGravity, 750, 20, Magick::OverCompositeOp)
  
    # Add next arm
    arm.rotate!(180)
    final = final.composite(arm, Magick::NorthWestGravity, 615, 200, Magick::OverCompositeOp)
    
    # write texture to file
    final.write(final_texture)
  end
end
