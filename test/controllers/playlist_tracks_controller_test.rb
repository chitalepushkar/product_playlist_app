require 'test_helper'

class PlaylistTracksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @playlist_track = playlist_tracks(:one)
  end

  test "should get index" do
    get playlist_tracks_url, as: :json
    assert_response :success
  end

  test "should create playlist_track" do
    assert_difference('PlaylistTrack.count') do
      post playlist_tracks_url, params: { playlist_track: { lyrics: @playlist_track.lyrics, playlist_id: @playlist_track.playlist_id, track_id: @playlist_track.track_id } }, as: :json
    end

    assert_response 201
  end

  test "should show playlist_track" do
    get playlist_track_url(@playlist_track), as: :json
    assert_response :success
  end

  test "should update playlist_track" do
    patch playlist_track_url(@playlist_track), params: { playlist_track: { lyrics: @playlist_track.lyrics, playlist_id: @playlist_track.playlist_id, track_id: @playlist_track.track_id } }, as: :json
    assert_response 200
  end

  test "should destroy playlist_track" do
    assert_difference('PlaylistTrack.count', -1) do
      delete playlist_track_url(@playlist_track), as: :json
    end

    assert_response 204
  end
end
