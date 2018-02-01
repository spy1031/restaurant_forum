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
  has_many :inverse_followships ,class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "friendship",foreign_key: "friend_id"
  has_many :friends_invite, through: :inverse_friendships,source: :user


  mount_uploader :avatar, AvatarUploader
  def admin?
    self.role == "admin"
  end

  def is_following?(user)
    self.followings.include?(user)
  end
  #藉由status來判斷 1.已提出友好邀請 2.可同意好友邀請 3.已成為好友
  def is_friend?(user)
    if self.friends.include?(user)
      return self.friendships.where(friend_id: user.id).first.status
    end
  end
end
