class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  scope :sort_by_time, ->{order created_at: :desc}
end
