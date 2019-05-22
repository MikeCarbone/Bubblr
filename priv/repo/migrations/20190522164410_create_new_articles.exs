defmodule Newsfun.Repo.Migrations.CreateNewArticles do
  use Ecto.Migration

  def change do
    create table(:new_articles) do
      add :title, :string
      add :article_id, :integer

      timestamps()
    end

  end
end
