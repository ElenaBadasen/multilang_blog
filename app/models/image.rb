class Image < ApplicationRecord
  mount_uploader :file, ImageUploader

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :users
end
