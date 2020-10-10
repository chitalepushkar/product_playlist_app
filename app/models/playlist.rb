class Playlist < ApplicationRecord
  include MusixMatchService

  has_many :playlist_tracks

  after_save :search_track

  def search_track
    fetch_track(self.id, self.category)
  end

  # Fetches the next matching track based on the current track id
  def next_track(current_track_id)
    current_track = PlaylistTrack.find(current_track_id)
    lyrics_chunk = current_track.lyrics.split[0...5].join(' ')
    new_track = self.fetch_track(self.id, lyrics_chunk)

    return PlaylistTrack.find(new_track.id) if new_track.present?
  end

  # Creates a playlist and fetches two tracks
  def self.create_with_tracks(options)
    playlist = self.create(options)
    if playlist.present?
      first_track = playlist.playlist_tracks.first
      playlist.next_track(first_track.id)
    end
    playlist
  end
end
