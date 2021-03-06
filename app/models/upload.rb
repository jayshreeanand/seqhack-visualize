require 'open-uri'

class Upload < ActiveRecord::Base

  attr_accessor :crop_front_x, :crop_front_y, :crop_front_w, :crop_front_h,  :crop_back_x, :crop_back_y, :crop_back_w, :crop_back_h,  :crop_arm_x, :crop_arm_y, :crop_arm_w, :crop_arm_h
  
  belongs_to :user

  serialize :front_image_details
  serialize :back_image_details
  serialize :arm_image_details

  before_save :generate_texture, if: Proc.new { |u| u.front_image_changed? || u.back_image_changed? || u.arm_image_changed? }
  
  mount_uploader :front_image, ImageUploader
  mount_uploader :back_image, ImageUploader
  mount_uploader :arm_image, ImageUploader
  mount_uploader :generated_texture, ImageUploader


  def crop_front_image
    front_image.recreate_versions! if crop_front_x.present?
  end

  def crop_back_image
    back_image.recreate_versions! if crop_back_x.present?
  end

  def crop_arm_image
    arm_image.recreate_versions! if crop_arm_x.present?
  end


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
    # if Rails.env.development?
      FileUtils.copy(front_image.file.path, resized_front_image) if front_image.file.present?
      FileUtils.copy(back_image.file.path, resized_back_image) if back_image.file.present?
      FileUtils.copy(arm_image.file.path, resized_arm_image) if arm_image.file.present?
    # else
    #   open(resized_front_image, 'wb') do |file|
    #     file << open(front_image.url).read
    #   end
    #   open(resized_back_image, 'wb') do |file|
    #     file << open(back_image.url).read
    #   end
    #   open(resized_arm_image, 'wb') do |file|
    #     file << open(arm_image.url).read
    #   end
    # end
  end
  
  def generate_texture
    if front_image && back_image && arm_image
      download_images

      final = Magick::Image.read(texture_background)[0]
      
      # Upload front side
      front = Magick::Image.read(resized_front_image)[0]
      front.resize_to_fill!(280, 325)
      front.write(resized_front_image)
      
      final = final.composite(front, Magick::NorthWestGravity, 125, 30, Magick::OverCompositeOp)

      # add first arm
      arm = Magick::Image.read(resized_arm_image)[0]
      arm.resize_to_fill!(260, 180)
      arm.write(resized_arm_image)
      
      final = final.composite(arm, Magick::NorthWestGravity, 750, 20, Magick::OverCompositeOp)
    
      # Add next arm
      arm.rotate!(180)
      final = final.composite(arm, Magick::NorthWestGravity, 615, 200, Magick::OverCompositeOp)
      
      # Split back into two
      back = Magick::Image.read(resized_back_image)[0]
      back.resize_to_fill!(230, 325)
      
      back_left = back.crop(Magick::NorthWestGravity, 0, 0, 115, 325, true)
      back_right = back.crop(Magick::NorthWestGravity, 115, 0, 115, 325, true)
      
      back_left.write(resized_back_left)
      back_right.write(resized_back_right)
      
      # add back left
      final = final.composite(back_left, Magick::NorthWestGravity, 10, 30, Magick::OverCompositeOp)
      
      # add right
      back_right.rotate!(180)
      final = final.composite(back_right, Magick::NorthWestGravity, 405, 30, Magick::OverCompositeOp)
      
      # write texture to file
      final.write(final_texture)
      
      self.generated_texture = File.open(final_texture)
    end
  end
end
