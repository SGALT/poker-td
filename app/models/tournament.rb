class Tournament < ApplicationRecord
  has_many :rounds, dependent: :destroy
  mount_uploader :photo, PhotoUploader
  mount_uploader :photo_opt, PhotoUploader
end
