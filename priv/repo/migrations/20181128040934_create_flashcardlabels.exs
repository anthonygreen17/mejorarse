defmodule Mejorarse.Repo.Migrations.CreateFlashcardlabels do
  use Ecto.Migration

  def change do
    create table(:flashcardlabels) do
      add :label, :string
      add :flashcard_id, references(:flashcards, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:flashcardlabels, [:label])
    create index(:flashcardlabels, [:flashcard_id])
  end
end
