defmodule MyPersonalCloudBackendWeb.MusicController do
  alias MyPersonalCloudBackend.Songs
  use MyPersonalCloudBackendWeb, :controller

  def index(conn, _params) do
    Songs.get_all_songs()
    |> IO.inspect(label: "res: ")

    case Songs.get_all_songs() do
      [] ->
        conn
        |> put_status(:ok)
        |> json(%{message: "no songs loaded"})

      songs ->
        songs = Enum.map(songs, &format_song/1)

        conn
        |> put_status(:ok)
        |> json(%{songs: songs})
    end
  end

  def load_music(
        conn,
        %{
          "new_song" =>
            %{
              "title" => _title,
              "year" => _year,
              "quality" => _quality,
              "artist" => _artist,
              "album" => _album,
              "time_listened" => _time_listened,
              "icon" => _icon,
              "song_file" => _song_file
            } = new_song
        }
      ) do
    case Songs.add_song(new_song) do
      {:ok, _} ->
        conn
        |> put_status(:ok)
        |> json(%{message: "song loaded"})

      {:error, _} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{message: "error loading songs"})

      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{message: "bad request"})
    end
  end

  def load_song(conn, %{"id" => id}) do
    case Songs.get_song(id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{message: "song not found"})

      song ->
        song = format_song(song) |> Map.put(:song_file, Base.encode64(song.song_file))

        conn
        |> put_status(:ok)
        |> json(%{song: song})
    end
  end

  defp format_song(song) do
    %{
      id: song.id,
      title: song.title,
      year: song.year,
      quality: song.quality,
      artist: song.artist,
      album: song.album,
      time_listened: song.time_listened,
      icon: song.icon
    }
  end
end
