class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  def index
  @books = Book.includes(:recommendations)
end


  def show
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to books_path, alert: "Book not found."
  end
end
