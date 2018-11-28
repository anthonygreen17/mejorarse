defmodule Mejorarse.Content.Flashcard do
  use Ecto.Schema
  import Ecto.Changeset


  schema "flashcards" do
    field :english_text, :string
    field :foreign_text, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(flashcard, attrs) do
    flashcard
    |> cast(attrs, [:foreign_text, :english_text])
    |> validate_required([:foreign_text, :english_text])
    |> unique_constraint(:foreign_text)
  end
end
