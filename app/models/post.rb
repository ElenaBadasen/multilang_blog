class Post < ApplicationRecord
  validates :content, presence: true
  belongs_to :category
  default_scope { order(created_at: :desc) }
end
