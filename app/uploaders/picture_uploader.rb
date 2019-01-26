class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [400, 400]
  
<<<<<<< HEAD
  if Rails.env == 'production'
=======
  
  if Rails.env.production?
>>>>>>> insta_development
    storage :fog
  else
    storage :file
  end
  
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end