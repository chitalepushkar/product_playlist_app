class PlaylistTrack < ApplicationRecord
  include MusixMatchService
  belongs_to :playlist

  after_create :search_lyrics

  def search_lyrics
    fetch_lyrics(self.id, self.track_id)
  end
end
