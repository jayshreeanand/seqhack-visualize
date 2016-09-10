# encoding: utf-8
class ImageUploader < BaseUploader
  include CarrierWave::RMagick

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
