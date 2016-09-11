# encoding: utf-8
class ImageUploader < BaseUploader
  include CarrierWave::RMagick
  include ActiveAdminJcrop::AssetEngine::CarrierWave

  process :store_dimensions
  process :active_admin_crop

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :thumb do
    process resize_to_fit: [100, 100]
  end

  def store_dimensions
    if file && model
      img = ::Magick::Image::read(file.file).first
      model.width = img.columns
      model.height = img.rows
    end
  end
end
