class RecommendationsController < ApplicationController
  def index
    @recommendations = Recommendation
      .includes(:book, :user, :votes)
      .all
      .sort_by do |rec|
      [
        -rec.votes.count,
        -(rec.votes.maximum(:created_at)&.to_i || 0), 
      ]
    end
  end

  def new
    @book = Book.find(params[:book_id])
    @recommendation = Recommendation.new
  end

  def create
    @book = Book.find(params[:book_id])
    @recommendation = current_user.recommendations.new(recommendation_params)
    @recommendation.book = @book

    if @recommendation.save
      redirect_to books_path, notice: "Recommendation added!"
    else
      flash[:alert] = @recommendation.errors.full_messages.to_sentence
      redirect_to books_path
    end
  end

  private

  def recommendation_params
    params.require(:recommendation).permit(:review)
  end
end
