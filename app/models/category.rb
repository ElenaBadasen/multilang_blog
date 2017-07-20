class Category < ApplicationRecord

  validates :name, :path, presence: true, uniqueness: true
  belongs_to :user

  has_many :posts

  has_and_belongs_to_many :images

  attr_accessor :file, :file_cache

end
