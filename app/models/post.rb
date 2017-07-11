class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  scope :sort_by_time, ->{order created_at: :desc}
end
