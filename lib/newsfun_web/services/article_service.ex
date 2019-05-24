defmodule Newsfun.ArticleFetcherService do
  import Ecto.Query

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

  def fetch_all_articles_desc do
    Article
    |> limit(10)
    |> order_by(desc: :score)
    |> Repo.all()
  end

  def fetch_all_articles do
    Repo.all(Article)
  end

  def build_feed(_new_article_list, _old_article_list) do
    # every 5 articles throw in a hot new one?
  end

  def delete_new_articles do
    Repo.delete_all(NewArticle)
  end

  def push_new_articles do
    # add newly queried articles to DB
    fresh_articles = fetch_articles()

    if fresh_articles !== nil do
      delete_new_articles()
    end

    Enum.each(fresh_articles, fn x ->
      if check_exists(x) == nil do
  
        add_to_new_articles(x)

        add_to_articles(x)

        IO.puts "-----"
        IO.puts "-----"
        IO.puts "^^ New article added! ^^"
        IO.puts "-----"
        IO.puts "-----"
      else
        IO.puts "Article exists, skipping..."
      end
    end)

  end

  def check_exists(article) do
    IO.puts article[:title]
    data = Repo.get_by(Article, [
      article_src: article[:url],
      title: article[:title]
    ])
    data
  end

  def add_to_articles(article) do
    Repo.insert(%Article{
      score: 1000,
      title: article[:title],
      description: article[:description],
      img_src: article[:img],
      source: article[:source],
      published_at: article[:publishedAt],
      article_src: article[:url]
    })
  end

  def add_to_new_articles(article) do
    Repo.insert(%NewArticle{
      title: article[:title],
      description: article[:description],
      img_src: article[:img],
      source: article[:source],
      published_at: article[:publishedAt],
      article_src: article[:url]
    })
  end

  def time_based_score_adjust(minutes) do
    adjustment = minutes * 10
    articles = fetch_all_articles()
    IO.puts "Editing score of articles..."
    Enum.each(articles, fn x ->
      new_score = x.score - adjustment
      IO.puts "Editing one..."
      IO.puts x.title
      IO.puts x.score
      ch = Article.changeset(x, %{score: new_score})
      if ch.valid? do
        Repo.update(ch)
        IO.puts "^^ done ^^"
        IO.puts "--------------------------"
      else
        IO.puts "^^ FAILURE ^^"
        IO.puts "--------------------------"
      end
    end)
  end

  def delete_all_articles do
    Repo.delete_all(Article)
  end
  # %{
  #   author: nil, 
  #   description: "CNN commentator David Axelrod slammed President Trump's presser on Thursday, calling it \"North Korean\" and suggested he was \"hanging with Kim Jong Un\" too much.", 
  #   img: "https://static.foxnews.com/foxnews.com/content/uploads/2018/09/axelrod-7c7851813f65b410VgnVCM100000d7c1a8c0____.jpg", 
  #   publishedAt: "2019-05-24T12:42:52Z", 
  #   source: "Fox News", 
  #   title: "CNN's David Axelrod calls Trump's presser 'North Korean': Maybe he's 'hanging with Kim Jong Un' too much - Fox News", 
  #   url: "https://www.foxnews.com/entertainment/cnn-david-axelrod-trump-presser-north-korea-kim-jong-un"
  # }
end