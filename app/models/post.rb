class Post < ApplicationRecord
  validates :content, presence: true
  belongs_to :category
  default_scope { order(priority: :desc, created_at: :desc) }
end
