class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image

# フォロー機能のアソシエーション
  has_many :relationships, class_name: 'Relationship', foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :relationships, source: :follower
  has_many :reverce_of_relationships, class_name: 'Relationship', foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :reverce_of_relationships, source: :followed

# DM機能のアソシエーション
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms

#閲覧数表示のアソシエーション
  has_many :view_counts, dependent: :destroy

#グループ機能のアソシエーション
  has_many :group_users, dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

# ユーザープロフィール画像
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

# フォロー機能
  def follow(user)
    reverce_of_relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    reverce_of_relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

# 検索機能
  def self.search_for(word,method)
    if method == 'perfect'
      User.where(name: word)
    elsif method == 'forward'
      User.where('name LIKE ?', "#{word}%")
    elsif method == 'backward'
      User.where('name LIKE ?', "%#{word}")
    elsif method == 'partial'
      User.where('name LIKE ?', "%#{word}%")
    end
  end
end
