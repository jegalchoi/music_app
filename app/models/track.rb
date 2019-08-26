class Track < ApplicationRecord
  validates :album_id, :title, :ord, presence: true
  
  belongs_to :album
end