defmodule Mejorarse.Repo.Migrations.CreateFlashcards do
  use Ecto.Migration

  def change do
    create table(:flashcards) do
      add :foreign_text, :string
      add :english_text, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:flashcards, [:foreign_text])
    create index(:flashcards, [:user_id])
  end
end
