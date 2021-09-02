class Comment < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :comment, presence: true, length: { maximum: 140 }
  belongs_to :animal
end
