class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments ,dependent: :restrict_with_error
  has_many :restaurants, through: :comments

  has_many :favorites, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant
  has_many :liked_restaurants, through: :likes, source: :restaurant
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships


  has_many :inverse_folloships ,class_name: "Followships",
  foreign_key: "following_id"
  has_many :follower, through: :inverse_folloships, source: :user

  mount_uploader :avatar, AvatarUploader
  def admin?
    self.role == "admin"
  end

  def is_following?(user)
    self.followings.include?(user)
  end
end
