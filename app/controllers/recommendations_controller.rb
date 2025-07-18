class RecommendationsController < ApplicationController
  def create
    @recommendation = current_user.recommendations.new(recommendation_params)
    if @recommendation.save
      redirect_to @recommendation, notice: 'Recommendation was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @recommendation = Recommendation.find(params[:id])
    if @recommendation.user == current_user
      @recommendation.destroy
      redirect_to recommendations_path, notice: 'Recommendation was successfully deleted.'
    else
      redirect_to recommendations_path, alert: 'You can only delete your own recommendations.'
    end
  end

  def self.trending
    left_joins(:votes)
      .group(:id)
      .order(Arel.sql("SUM(CASE WHEN votes.created_at > NOW() - interval '1 day' THEN 2 ELSE 1 END) DESC"))
  end
end
