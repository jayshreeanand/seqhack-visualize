class Upload < ActiveRecord::Base

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  belongs_to :user

  serialize :front_image_details
  serialize :back_image_details
  serialize :arm_image_details
  
  mount_uploader :front_image, ImageUploader
  mount_uploader :back_image, ImageUploader
  mount_uploader :arm_image, ImageUploader
  
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
    File.write(resized_front_image, front_image.read)
    File.write(resized_back_image, back_image.read)
    File.write(resized_arm_image, arm_image.read)
  end
  
  def generate_texture
    base_texture = Magick::Image.read(texture_background)[0]
    
    download_images
    
    front = Magick::Image.read(resized_front_image.path)[0]
    front.resize_to_fill!(280, 325)
    
    result = base_texture.composite(front, Magick::NorthWestGravity, 125, 30, Magick::OverCompositeOp)
    result.write(final_texture)
  end
end
