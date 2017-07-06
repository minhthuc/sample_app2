class Micropost < ApplicationRecord
  belongs_to :user

  scope :select_item, -> id {where "user_id = ?", id}
  scope :sort_by_time, ->{order created_at: :desc}

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.micropost
    .content.max_length}
  validate :picture_size

  private

  def picture_size
    errors.add(:picture, t("microposts.model.picture_warning")) if picture
      .size > Settings.microposts.max_size.megabytes
  end
end
