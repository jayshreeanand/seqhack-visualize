# encoding: utf-8
class ImageUploader < BaseUploader
  include CarrierWave::RMagick
  include ActiveAdminJcrop::AssetEngine::CarrierWave

  process :store_dimensions
  process :active_admin_crop
  # process :crop
  
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

  # def crop
  #   if model.methods.include?(:crop_x) && model.crop_x.present?
  #     manipulate! do |img|
  #       x = model.crop_x
  #       y = model.crop_y
  #       w = model.crop_w
  #       h = model.crop_h

  #       img.crop("#{w}x#{h}+#{x}+#{y}")
  #       img
  #     end
  #   end
  # end
end
