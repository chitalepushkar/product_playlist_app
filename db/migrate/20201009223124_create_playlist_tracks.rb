class CreatePlaylistTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :playlist_tracks do |t|
      t.references :playlist, null: false, foreign_key: true
      t.integer :track_id, null: false, unsigned: true, index: true
      t.string :title
      t.string :artist
      t.text :lyrics

      t.timestamps
    end
  end
end
