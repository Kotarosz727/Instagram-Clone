class User < ApplicationRecord
  attr_accessor :reset_token
   
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy                                
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
  #facebook認証
  #validates :user, presence: true, unless: :uid? 
  #validates :email, presence: true, unless: :uid?
  #has_secure_password validations: false
  #validates :password, presence: true, unless: :uid?
  
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
   
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

 
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
    
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  
  def feed
   following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end
  
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
  
  def self.search(search) 
    if search
      where(['name LIKE ?', "%#{search}%"]) 
    else
      all 
    end
  end
  
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    image = auth[:info][:image]
 
    self.find_or_create_by(provider: provider, uid: uid) do |user|
    user.username = name
    user.image_path = image
  end
  end
  
  private
   def downcase_email
      self.email = email.downcase
    end
end