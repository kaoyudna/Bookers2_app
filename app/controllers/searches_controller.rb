class SearchesController < ApplicationController

  def search
    @model = params[:model]
    @word = params[:word]
    @method = params[:method]
    if @model == 'user'
      @records = User.search_for(@word,@method)
    else @model == 'Book'
      @records = Book.search_for(@word,@method)
    end
  end
end
