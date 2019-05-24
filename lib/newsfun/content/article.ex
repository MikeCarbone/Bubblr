defmodule Newsfun.Content.Article do
  use Ecto.Schema
  import Ecto.Changeset

  alias Newsfun.ArticleFetcherService, as: AFS

  schema "articles" do
    field :score, :integer
    field :title, :string
    field :published_at, :string
    field :publisher, :string
    field :short_title, :string
    field :source, :string
    field :img_src, :string
    field :article_src, :string
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:score])
    |> validate_required([:score])
  end
end
