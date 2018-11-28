defmodule Mejorarse.ContentTest do
  use Mejorarse.DataCase

  alias Mejorarse.Content

  describe "flashcards" do
    alias Mejorarse.Content.Flashcard

    @valid_attrs %{english_text: "some english_text", foreign_text: "some foreign_text"}
    @update_attrs %{english_text: "some updated english_text", foreign_text: "some updated foreign_text"}
    @invalid_attrs %{english_text: nil, foreign_text: nil}

    def flashcard_fixture(attrs \\ %{}) do
      {:ok, flashcard} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_flashcard()

      flashcard
    end

    test "list_flashcards/0 returns all flashcards" do
      flashcard = flashcard_fixture()
      assert Content.list_flashcards() == [flashcard]
    end

    test "get_flashcard!/1 returns the flashcard with given id" do
      flashcard = flashcard_fixture()
      assert Content.get_flashcard!(flashcard.id) == flashcard
    end

    test "create_flashcard/1 with valid data creates a flashcard" do
      assert {:ok, %Flashcard{} = flashcard} = Content.create_flashcard(@valid_attrs)
      assert flashcard.english_text == "some english_text"
      assert flashcard.foreign_text == "some foreign_text"
    end

    test "create_flashcard/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_flashcard(@invalid_attrs)
    end

    test "update_flashcard/2 with valid data updates the flashcard" do
      flashcard = flashcard_fixture()
      assert {:ok, %Flashcard{} = flashcard} = Content.update_flashcard(flashcard, @update_attrs)
      assert flashcard.english_text == "some updated english_text"
      assert flashcard.foreign_text == "some updated foreign_text"
    end

    test "update_flashcard/2 with invalid data returns error changeset" do
      flashcard = flashcard_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_flashcard(flashcard, @invalid_attrs)
      assert flashcard == Content.get_flashcard!(flashcard.id)
    end

    test "delete_flashcard/1 deletes the flashcard" do
      flashcard = flashcard_fixture()
      assert {:ok, %Flashcard{}} = Content.delete_flashcard(flashcard)
      assert_raise Ecto.NoResultsError, fn -> Content.get_flashcard!(flashcard.id) end
    end

    test "change_flashcard/1 returns a flashcard changeset" do
      flashcard = flashcard_fixture()
      assert %Ecto.Changeset{} = Content.change_flashcard(flashcard)
    end
  end
end
