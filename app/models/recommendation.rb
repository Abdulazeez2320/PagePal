class Recommendation < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :votes, dependent: :destroy

  validates :review, length: { maximum: 250 }
  validates :book_id, uniqueness: { scope: :user_id, message: "has already been recommended by you" }
end
