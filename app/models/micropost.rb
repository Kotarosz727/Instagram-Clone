class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  
  def like_user(user_id)
   likes.find_by(user_id: user_id)
  end
  
  def self.search(search) 
    if search
      where(['content LIKE ?', "%#{search}%"])
    else
      all 
    end
  end

  private

    
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "５MBを超えています")
      end
    end
end