defmodule MyPersonalCloudBackend.Songs.Song do
  use Ecto.Schema
  import Ecto.Changeset

  schema "songs" do
    field :title, :string
    field :year, :string
    field :quality, :string
    field :artist, :string
    field :album, :string
    field :time_listened, :integer
    field :icon, :string
    field :song_file, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(song, attrs) do
    song
    |> cast(attrs, [:title, :quality, :artist, :album, :year, :time_listened, :icon, :song_file])
    |> validate_required([
      :title,
      :quality,
      :artist,
      :album,
      :year,
      :time_listened,
      :icon,
      :song_file
    ])
  end
end
