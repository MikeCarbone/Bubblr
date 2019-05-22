defmodule NewsfunWeb.TestController do
  use NewsfunWeb, :controller
  alias Newsfun.ArticleFetcherService, as: AFS

  def index(conn, _params) do
      article_list = AFS.fetch_current_feed

    render(conn, "index.html", data: %{:article_list => article_list})
  end

  def show(conn, %{"messenger" => messenger}) do
    render(conn, "show.html", messenger: messenger)
  end
end