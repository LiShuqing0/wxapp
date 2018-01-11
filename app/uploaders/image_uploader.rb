# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
  storage :file

  process resize_to_fit: [800, 800]

  version :thumb do
    process resize_to_fill: [100,100]
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  

end
