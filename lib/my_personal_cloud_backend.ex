defmodule MyPersonalCloudBackend do
  @moduledoc """
  MyPersonalCloudBackend keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias MyPersonalCloudBackend.Songs

  def setup do
    %{
      title: "Song Title",
      year: "2023",
      quality: "320kbps",
      artist: "Artist Name",
      album: "Album Name",
      time_listened: 0,
      icon: "icon.png",
      song_file: "song.mp3"
    }
    |> Songs.add_song()
  end
end
