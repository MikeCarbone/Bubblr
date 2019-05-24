defmodule Newsfun.Repo.Migrations.ChangeStringToTypeText do
  use Ecto.Migration

  def change do
    alter table(:new_articles) do
      modify :title, :text
      modify :published_at, :text
      modify :publisher, :text
      modify :short_title, :text
      modify :source, :text
      modify :img_src, :text
      modify :article_src, :text
      modify :description, :text
    end

    alter table(:articles) do
      modify :title, :text
      modify :published_at, :text
      modify :publisher, :text
      modify :short_title, :text
      modify :source, :text
      modify :img_src, :text
      modify :article_src, :text
      modify :description, :text
    end

  end
end
