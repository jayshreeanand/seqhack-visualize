# encoding: utf-8
class ImageUploader < BaseUploader
  include CarrierWave::RMagick
  include ActiveAdminJcrop::AssetEngine::CarrierWave

  # process :store_dimensions
  process :active_admin_crop
  process :crop
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :thumb do
    process resize_to_fit: [100, 100]
  end

  version :normal do
  end
  
  def store_dimensions
    if file && model
      img = ::Magick::Image::read(file.file).first
      detail_attribute = "#{mounted_as}_details"
      model.send(detail_attribute+'=', { width: img.columns, height: img.rows })
    end
  end

  def crop
    if mounted_as == 'front_image'
      if model.methods.include?(:crop_front_x) && model.crop_front_x.present?
        manipulate! do |img|
          x = model.crop_front_x
          y = model.crop_front_y
          w = model.crop_front_w
          h = model.crop_front_h

          img.crop("#{w}x#{h}+#{x}+#{y}")
          img
        end
      end
    elsif mounted_as == 'back_image'
      if model.methods.include?(:crop_back_x) && model.crop_back_x.present?
        manipulate! do |img|
          x = model.crop_back_x
          y = model.crop_back_y
          w = model.crop_back_w
          h = model.crop_back_h

          img.crop("#{w}x#{h}+#{x}+#{y}")
          img
        end
      end
    elsif mounted_as == 'arm_image'
      if model.methods.include?(:crop_arm_x) && model.crop_arm_x.present?
        manipulate! do |img|
          x = model.crop_arm_x
          y = model.crop_arm_y
          w = model.crop_arm_w
          h = model.crop_arm_h

          img.crop("#{w}x#{h}+#{x}+#{y}")
          img
        end
      end
    end
      
  end
end
