defmodule MyPersonalCloudBackend.Repo.Migrations.CreateSongs do
  use Ecto.Migration

  def change do
    create table(:songs) do
      add :title, :string
      add :quality, :string
      add :artist, :string
      add :album, :string
      add :year, :string
      add :time_listened, :integer
      add :icon, :string
      add :song_file, :text

      timestamps(type: :utc_datetime)
    end
  end
end
