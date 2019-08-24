class Track < ApplicationRecord
  validates :album_id, :title, :ord, presence: true

  belongs_to :album

  belongs_to :band,
    through: :album
end