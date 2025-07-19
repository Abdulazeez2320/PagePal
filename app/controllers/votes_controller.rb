class VotesController < ApplicationController
  def create
  recommendation = Recommendation.find(params[:recommendation_id])
  if current_user.votes.exists?(recommendation_id: recommendation.id)
    redirect_back fallback_location: books_path, alert: "You already voted!"
  else
    current_user.votes.create(recommendation: recommendation)
    redirect_back fallback_location: books_path, notice: "Voted!"
  end
end



  def destroy
  @recommendation = Recommendation.find(params[:recommendation_id])
  current_user.votes.find_by(recommendation: @recommendation).destroy 
  end
end
