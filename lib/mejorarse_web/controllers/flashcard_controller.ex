defmodule MejorarseWeb.FlashcardController do
  use MejorarseWeb, :controller

  alias Mejorarse.Content
  alias Mejorarse.Content.Flashcard
  alias Mejorarse.Accounts

  def action(conn, _) do
    user = Accounts.get_user!(conn.params["user_id"])
    args = [conn, conn.params, user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, user) do
    flashcards = Content.list_flashcards(user.id)
    require IEx; IEx.pry()
    render(conn, "index.html", flashcards: flashcards, user: user)
  end

  def new(conn, _params, user) do
    changeset = Content.change_flashcard(%Flashcard{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"flashcard" => flashcard_params}, user) do
    case Content.create_flashcard(flashcard_params) do
      {:ok, flashcard} ->
        conn
        |> put_flash(:info, "Flashcard created successfully.")
        |> redirect(to: Routes.user_flashcard_path(conn, :show, flashcard, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    flashcard = Content.get_flashcard!(id)
    render(conn, "show.html", flashcard: flashcard)
  end

  def edit(conn, %{"id" => id}, user) do
    flashcard = Content.get_flashcard!(id)
    changeset = Content.change_flashcard(flashcard)
    render(conn, "edit.html", flashcard: flashcard, changeset: changeset)
  end

  def update(conn, %{"id" => id, "flashcard" => flashcard_params}, user) do
    flashcard = Content.get_flashcard!(id)

    case Content.update_flashcard(flashcard, flashcard_params) do
      {:ok, flashcard} ->
        conn
        |> put_flash(:info, "Flashcard updated successfully.")
        |> redirect(to: Routes.user_flashcard_path(conn, :show, flashcard, user.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", flashcard: flashcard, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    flashcard = Content.get_flashcard!(id)
    {:ok, _flashcard} = Content.delete_flashcard(flashcard)

    conn
    |> put_flash(:info, "Flashcard deleted successfully.")
    |> redirect(to: Routes.user_flashcard_path(conn, :index, user.id))
  end
end
