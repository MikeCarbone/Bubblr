defmodule Newsfun.Repo.Migrations.AddNewArticleFields do
  use Ecto.Migration

  def change do
    alter table(:new_articles) do
      add :published_at, :string
      add :publisher, :string
      add :short_title, :string
      add :source, :string
      add :img_src, :string
      add :article_src, :string
    end

    alter table(:articles) do
      add :published_at, :string
      add :publisher, :string
      add :short_title, :string
      add :source, :string
      add :img_src, :string
      add :article_src, :string
    end

  end
end
