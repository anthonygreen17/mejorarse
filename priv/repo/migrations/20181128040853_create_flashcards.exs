defmodule Mejorarse.Repo.Migrations.CreateFlashcards do
  use Ecto.Migration

  def change do
    create table(:flashcards) do
      add :foreign_text, :string
      add :english_text, :string

      # delete flashcards for a user when the user is deleted
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:flashcards, [:foreign_text])
    create index(:flashcards, [:user_id])
  end
end
