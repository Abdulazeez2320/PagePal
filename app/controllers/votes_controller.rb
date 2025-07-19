class VotesController < ApplicationController
  def create
    recommendation = Recommendation.find(params[:recommendation_id])

    # Prevent voting for own recommendation
    if recommendation.user_id == current_user.id
      redirect_back fallback_location: recommendations_path, alert: "You cannot vote for your own recommendation."
      return
    end

    # Prevent duplicate votes
    if current_user.votes.exists?(recommendation_id: recommendation.id)
      redirect_back fallback_location: recommendations_path, alert: "You already voted!"
      return
    end

    # Cast vote
    current_user.votes.create!(recommendation: recommendation)
    redirect_back fallback_location: recommendations_path, notice: "Thanks for your vote!"
  end

  def destroy
    @recommendation = Recommendation.find(params[:recommendation_id])
    current_user.votes.find_by(recommendation: @recommendation).destroy
  end
end
