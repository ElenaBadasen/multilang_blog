class Post < ApplicationRecord
  validate :category_is_not_header
  validates :content, :created_at, presence: true
  belongs_to :category
  default_scope { order(priority: :desc, created_at: :desc) }

  def category_is_not_header
    if category.destination == "header"
      errors.add(:category, I18n.t('category_should_not_be_header'))
    end
  end
end
