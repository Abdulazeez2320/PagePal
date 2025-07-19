class UsersController < ApplicationController
   before_action :authenticate_user!

  def profile
    @user = current_user
    @recommendations = @user.recommendations.includes(:book)
    @votes_count = @user.votes.count
  end
end
