json.extract! playlist, :id, :category, :created_at, :updated_at
json.set! :tracks do
  json.array! playlist.playlist_tracks, partial: "playlist_tracks/playlist_track", as: :playlist_track
end
