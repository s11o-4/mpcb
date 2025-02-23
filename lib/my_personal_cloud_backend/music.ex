defmodule MyPersonalCloudBackend.Songs do
  alias MyPersonalCloudBackend.Repo
  alias MyPersonalCloudBackend.Songs.Song

  def get_all_songs() do
    Repo.all(Song)
  end

  def add_song(new_song) do
    %Song{}
    |> Song.changeset(new_song)
    |> Repo.insert()
  end

  def get_song(id) do
    Repo.get(Song, id)
  end
end
