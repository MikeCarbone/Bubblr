defmodule Newsfun.Content.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :score, :integer
    field :title, :string
    field :publishedAt, :string
    field :publisher, :string
    field :shortTitle, :string
    field :source, :string
    field :img_src, :string
    field :article_src, :string

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :score])
    |> validate_required([:title, :score])
  end
end
