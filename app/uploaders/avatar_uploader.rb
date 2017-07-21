class AvatarUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => 'avatar'

  version :standard do
    process :resize_to_fill => [100, 150, :north]
  end

  version :thumbnail do
    resize_to_fit(50, 50)
  end

  version :banner do
    process :resize_to_fill => [1381, 457]
  end

  version :banner do
    process :resize_to_
  end

end
