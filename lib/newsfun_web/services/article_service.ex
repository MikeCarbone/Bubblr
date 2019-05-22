defmodule Newsfun.ArticleFetcherService do
  alias Newsfun.Content.Article
  alias Newsfun.NewArticle
  alias Newsfun.Repo

  def fetch_articles do
    api_key = "690c025f46e34f8bb3a7cc4ae46f8988"
    url = "https://newsapi.org/v2/top-headlines"
    params = "country=us"
    req_url = "#{url}?#{params}&apiKey=#{api_key}"

    ugly_response = HTTPoison.get!(req_url)
    response = Poison.decode!(ugly_response.body)

    Enum.reduce(response["articles"], [], fn a, acc ->
      acc ++ [%{
        :author => a["author"],
        :title => a["title"],
        :publishedAt => a["publishedAt"],
        :url => a["url"],
        :description => a["description"],
        :img => a["urlToImage"],
        :source => a["source"]["name"]
      }]
    end)
  end

  def fetch_current_feed do
    # Get top ~50 articles by score
    Repo.all(NewArticle)
  end

  def build_feed(new_article_list, old_article_list) do
    # every 5 articles throw in a hot new one?
  end

  def damage_feed do
    # reduce score of old articles
  end

  def push_new_articles do
    # add newly queried articles to DB
    fresh_articles = fetch_articles()

    Enum.each(fresh_articles, fn x ->
      IO.puts x[:description]
      Repo.insert(%NewArticle{
        title: x[:title],
      #   description: x[:description],
        img_src: x[:img],
        source: x[:source],
        published_at: x[:publishedAt],
        article_src: x[:url]
      })
    end)

  end


end