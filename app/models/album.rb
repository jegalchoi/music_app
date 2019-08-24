class Album < ApplicationRecord
  validates :band_id, presence: true
  validates :title, presence: true, uniqueness: true

  belongs_to :band
end