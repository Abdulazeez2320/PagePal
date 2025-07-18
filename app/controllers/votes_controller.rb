class VotesController < ApplicationController
  def create
  @recommendation = Recommendation.find(params[:recommendation_id])
  current_user.votes.create!(recommendation: @recommendation)
end


  def destroy
  @recommendation = Recommendation.find(params[:recommendation_id])
  current_user.votes.find_by(recommendation: @recommendation).destroy 
  end
end
