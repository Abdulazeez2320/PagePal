class Recommendation < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :votes, dependent: :destroy

  validates :review, length: { maximum: 250 }

end
