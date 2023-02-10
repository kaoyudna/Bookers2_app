class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy

#いいね機能のアソシエーション
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

#閲覧数表示のアソシエーション
  has_many :view_counts, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

#いいねが存在しているか
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

#検索機能
  def self.search_for(word,method)
    if method == 'perfect'
      Book.where(title: word)
    elsif method == 'forward'
      Book.where('title LIKE ?',"#{word}%")
    elsif method == 'backward'
      Book.where('title LIKE ?',"%#{word}")
    elsif method == 'partial'
      Book.where('title LIKE ?',"%#{word}%")
    end
  end
end
