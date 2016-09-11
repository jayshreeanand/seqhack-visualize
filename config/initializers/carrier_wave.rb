require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  if Rails.env.production? || Rails.env.staging?
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.secrets.aws_access_key_id,
      aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
      persistent: false,
      region: Rails.application.secrets.fog_region
    }
    config.fog_directory = Rails.application.secrets.fog_directory
    config.storage = :fog
    config.remove_previously_stored_files_after_update = true
    config.asset_host = "https://s3.amazonaws.com/#{Rails.applicaiton.secrets.fog_directory}"
  else
    config.storage = :file
  end

  config.asset_host = ENV['ASSET_HOST']

  if Rails.env.test?
    config.enable_processing = false
  end
end
