class Micropost < ApplicationRecord
  belongs_to :user

  scope :select_item, lambda{|id, following_ids|
    where "user_id IN (:following_ids) OR user_id =:user_id",
    following_ids: following_ids, user_id: id}
  scope :sort_by_time, ->{order created_at: :desc}

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.micropost
    .content.max_length}
  validate :picture_size

  private

  def picture_size
    errors.add(:picture, t("microposts.model.picture_warning")) if picture
      .size > Settings.micropost.size.megabytes
  end
end
