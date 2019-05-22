defmodule Newsfun.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :score, :integer

      timestamps()
    end

  end
end
