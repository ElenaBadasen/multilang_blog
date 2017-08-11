class Category < ApplicationRecord
  validate :path_should_be_unique_for_user
  validate :no_header_if_posts

  validates :destination, presence: true
  validates :path, presence: true
  belongs_to :user

  has_many :posts

  has_and_belongs_to_many :images

  enum destination: ["basic", "header"]

  attr_accessor :file, :file_cache

  def self.any_destination_to_text(destination)
    destination == "basic" ? I18n.t('main_destination') : I18n.t('header_destination')
  end

  default_scope { order(priority: :desc, created_at: :asc) }

  def path_should_be_unique_for_user
    if path.present?
      error = false
      user.categories.each do |c|
        if c == self
          next
        end
        if c.path == path
          error = true
          break
        end
      end
    end
    if error
      errors.add(:path, I18n.t('should_be_unique_for_user'))
    end
  end

  def no_header_if_posts
    if destination == "header" and posts.count > 0
      errors.add(:header, I18n.t('no_header_if_posts'))
    end
  end
end
