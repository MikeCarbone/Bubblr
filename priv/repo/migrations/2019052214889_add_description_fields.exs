defmodule Newsfun.Repo.Migrations.AddNewArticleFields do
  use Ecto.Migration

  def change do
    alter table(:new_articles) do
      add :description, :string
    end

    alter table(:articles) do
      add :description, :string
    end

  end
end
