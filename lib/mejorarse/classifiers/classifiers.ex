defmodule Mejorarse.Classifiers do
  @moduledoc """
  The Classifiers context.
  """

  import Ecto.Query, warn: false
  alias Mejorarse.Repo

  alias Mejorarse.Classifiers.FlashcardLabel

  @doc """
  Returns the list of flashcardlabels.

  ## Examples

      iex> list_flashcardlabels()
      [%FlashcardLabel{}, ...]

  """
  def list_flashcardlabels do
    Repo.all(FlashcardLabel)
  end

  @doc """
  Gets a single flashcard_label.

  Raises `Ecto.NoResultsError` if the Flashcard label does not exist.

  ## Examples

      iex> get_flashcard_label!(123)
      %FlashcardLabel{}

      iex> get_flashcard_label!(456)
      ** (Ecto.NoResultsError)

  """
  def get_flashcard_label!(id), do: Repo.get!(FlashcardLabel, id)

  @doc """
  Creates a flashcard_label.

  ## Examples

      iex> create_flashcard_label(%{field: value})
      {:ok, %FlashcardLabel{}}

      iex> create_flashcard_label(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_flashcard_label(attrs \\ %{}) do
    %FlashcardLabel{}
    |> FlashcardLabel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a flashcard_label.

  ## Examples

      iex> update_flashcard_label(flashcard_label, %{field: new_value})
      {:ok, %FlashcardLabel{}}

      iex> update_flashcard_label(flashcard_label, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_flashcard_label(%FlashcardLabel{} = flashcard_label, attrs) do
    flashcard_label
    |> FlashcardLabel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FlashcardLabel.

  ## Examples

      iex> delete_flashcard_label(flashcard_label)
      {:ok, %FlashcardLabel{}}

      iex> delete_flashcard_label(flashcard_label)
      {:error, %Ecto.Changeset{}}

  """
  def delete_flashcard_label(%FlashcardLabel{} = flashcard_label) do
    Repo.delete(flashcard_label)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking flashcard_label changes.

  ## Examples

      iex> change_flashcard_label(flashcard_label)
      %Ecto.Changeset{source: %FlashcardLabel{}}

  """
  def change_flashcard_label(%FlashcardLabel{} = flashcard_label) do
    FlashcardLabel.changeset(flashcard_label, %{})
  end
end
