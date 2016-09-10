# encoding: utf-8
class ImageUploader < BaseUploader
  include CarrierWave::RMagick

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  version :normal do
    process resize_to_fit: [360, 360]
  end

  version :retina do
    process resize_to_fit: [720, 720]
  end

  version :retina_plus do
    process resize_to_fit: [1080, 1080]
  end
end
