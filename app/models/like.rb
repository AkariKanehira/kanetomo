class Like < ApplicationRecord
  belongs_to :sake
  belongs_to :user
  validates_uniqueness_of :sake_id, scope: :user_id
end
