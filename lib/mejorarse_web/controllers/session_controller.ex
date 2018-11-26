defmodule MejorarseWeb.SessionController do
  use MejorarseWeb, :controller

  alias Mejorarse.Accounts.User

  # Allow users to login with either their email or their username
  # does the "user" map need to be here? or can we pattern match the inner map...
  def create(conn, %{"user" => %{"username_or_email" => username_or_email, "password" => password}}) do
    user = User.get_and_auth_user(username_or_email, password)
    cond do
      user != nil ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Logged in as #{user.username}")
        |> redirect(to: Routes.user_path(conn, :show, user))
      true ->
        conn
        |> put_session(:user_id, nil)
        |> put_flash(:error, "That user does not exist")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    require IEx; IEx.pry()
    conn
    |> put_session(:user_id, nil)
    |> put_flash(:info, "Logged out")
    |> redirect(to: Routes.page_path(conn, :index))
  end

end

#   def new(conn, _) do
#     render(conn, "new.html")
#   end

#   def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
#     case Accounts.authenticate_by_email_password(email, password) do
#       {:ok, user} ->
#         conn
#         |> put_flash(:info, "Welcome back!")
#         |> put_session(:user_id, user.id)
#         |> configure_session(renew: true)
#         |> redirect(to: "/")
#       {:error, :unauthorized} ->
#         conn
#         |> put_flash(:error, "Bad email/password combination")
#         |> redirect(to: Routes.session_path(conn, :new))
#     end
#   end

#   def delete(conn, _) do
#     conn
#     |> configure_session(drop: true)
#     |> redirect(to: "/")
#   end
# end