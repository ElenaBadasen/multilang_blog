class Image < ApplicationRecord
  mount_uploader :file, ImageUploader
  validates :file, presence: true

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :users

  default_scope { order(created_at: :desc) }
end
