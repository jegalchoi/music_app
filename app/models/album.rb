class Album < ApplicationRecord
  validates :band_id, presence: true
end