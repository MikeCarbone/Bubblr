defmodule NewsfunWeb.PageController do
  use NewsfunWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
