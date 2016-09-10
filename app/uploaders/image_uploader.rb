# encoding: utf-8
class ImageUploader < BaseUploader
  include CarrierWave::RMagick

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :thumb do
    process resize_to_fit: [100, 100]
  end
end
