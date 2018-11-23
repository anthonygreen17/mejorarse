defmodule MejorarseWeb.PageController do
  use MejorarseWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
