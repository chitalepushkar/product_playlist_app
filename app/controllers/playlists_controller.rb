class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:next_track]

  def next_track
    @playlist_track = @playlist.next_track(params[:current_track_id])
    if @playlist_track.present?
      render 'playlist_tracks/show', status: :ok
    else
      render json: {}, status: :not_found
    end
  end

  def create
    @playlist = Playlist.create_with_tracks(playlist_params)

    if @playlist
      render :show, status: :created
    else
      render json: @playlist.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def playlist_params
      params.require(:playlist).permit(:category)
    end
end
