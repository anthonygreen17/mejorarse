defmodule MejorarseWeb.Router do
  use MejorarseWeb, :router

  import MejorarseWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MejorarseWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/users", UserController do
      resources "/flashcards", FlashcardController
    end

    # resources "/sessions", SessionController, only: [:create, :delete],
                                              # singleton: true
    post "/sessions", SessionController, :login, singleton: true
    delete "/sessions", SessionController, :logout, singleton: true

  end

  # Other scopes may use custom stacks.
  # scope "/api", MejorarseWeb do
  #   pipe_through :api
  # end
end
