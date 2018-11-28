defmodule Mejorarse.Classifiers.FlashcardLabel do
  use Ecto.Schema
  import Ecto.Changeset


  schema "flashcardlabels" do
    field :label, :string
    field :flashcard_id, :id

    timestamps()
  end

  @doc false
  def changeset(flashcard_label, attrs) do
    flashcard_label
    |> cast(attrs, [:label])
    |> validate_required([:label])
    |> unique_constraint(:label)
  end
end
