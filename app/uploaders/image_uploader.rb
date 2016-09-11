# encoding: utf-8
class ImageUploader < BaseUploader
  include CarrierWave::MiniMagick
  include ActiveAdminJcrop::AssetEngine::CarrierWave

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :thumb do
    process :active_admin_crop
    process resize_to_fit: [100, 100]
  end

  version :normal do
    process :active_admin_crop
  end
end
