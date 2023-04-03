class TagMap < ApplicationRecord
  belongs_to :sake
  belongs_to :tag
  validates :sake_id, presence: true
  validates :tag_id, presence: true
end
