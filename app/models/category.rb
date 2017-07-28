class Category < ApplicationRecord

  validates :name, :path, presence: true, uniqueness: true
  validates :destination, presence: true
  belongs_to :user

  has_many :posts

  has_and_belongs_to_many :images

  enum destination: ["basic", "header"]

  attr_accessor :file, :file_cache

  def self.any_destination_to_text(destination)
    destination == "basic" ? I18n.t('main_destination') : I18n.t('header_destination')
  end
end
