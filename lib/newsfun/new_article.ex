defmodule Newsfun.NewArticle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "new_articles" do
    field :article_id, :integer
    field :title, :string
    field :published_at, :string
    field :publisher, :string
    field :short_title, :string
    field :source, :string
    field :img_src, :string
    field :article_src, :string

    timestamps()
  end

  @doc false
  def changeset(new_article, attrs) do
    new_article
    |> cast(attrs, [:title, :article_id])
    |> validate_required([:title, :article_id])
  end
end
