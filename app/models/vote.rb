class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :recommendation

  validate :cannot_vote_for_own_recommendation
  validates :user_id, uniqueness: { scope: :recommendation_id, message: "has already voted for this recommendation" }

  private

  def cannot_vote_for_own_recommendation
    if recommendation.user_id == user_id
      errors.add(:user_id, "cannot vote for their own recommendation")
    end
  end
end
