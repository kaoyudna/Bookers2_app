class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save

    #投稿一覧画面の非同期に必要な変数
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort {|a,b|
        b.favorited_users.where(created_at: from...to).size <=>
        a.favorited_users.where(created_at: from...to).size
      }
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy

    #投稿一覧画面の非同期に必要な変数
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort {|a,b|
        b.favorited_users.where(created_at: from...to).size <=>
        a.favorited_users.where(created_at: from...to).size
      }
  end
end
