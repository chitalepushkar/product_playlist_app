module MusixMatchService
  def call_musix_match(url, options={})
    common_params = {
      format: 'json',
      callback: 'callback',
      apikey: '12832752fc79e94b205e24b1a5bf7a4d'
    }

    response = HTTParty.get(
      url, query: common_params.merge!(options),
      headers: {'Content-Type': 'application/json'}
    )

    if response.code == 200
      response_body = JSON.parse(response.body)
      message_header = response_body['message']['header']
      if message_header['status_code'] == 200
        return response_body['message']['body']
      else
        raise StandardError.new 'MusixMatch API body incorrect'
      end
    else
      raise StandardError.new 'MusixMatch API failed'
    end
  end

  def fetch_track(playlist_id, category)
    # TODO: Fetch from configs
    query_params = {
      quorum_factor: 1,
      q_lyrics: category
    }

    track_body = call_musix_match(
      'https://api.musixmatch.com/ws/1.1/track.search',
      query_params
    )

    if track_body
      track_body['track_list'].each do |element|
        unless PlaylistTrack.exists?(playlist_id: playlist_id, track_id: element['track']['track_id'])
          return PlaylistTrack.create(
            playlist_id: playlist_id,
            track_id: element['track']['track_id'],
            title: element['track']['track_name'],
            artist: element['track']['artist_name'],
          )
        end
        next
      end
      PlaylistTrack.none
    end
  end

  def fetch_lyrics(playlist_track_id, musix_track_id)
    # TODO: Fetch from configs
    query_params = {
      track_id: musix_track_id
    }

    lyrics_body = call_musix_match(
      'https://api.musixmatch.com/ws/1.1/track.lyrics.get',
      query_params
    )

    if lyrics_body.present?
      PlaylistTrack
        .where(id: playlist_track_id)
        .update(lyrics: lyrics_body['lyrics']['lyrics_body'])
    end
  end
end
