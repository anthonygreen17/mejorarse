defmodule Mejorarse.ClassifiersTest do
  use Mejorarse.DataCase

  alias Mejorarse.Classifiers

  describe "flashcardlabels" do
    alias Mejorarse.Classifiers.FlashcardLabel

    @valid_attrs %{label: "some label"}
    @update_attrs %{label: "some updated label"}
    @invalid_attrs %{label: nil}

    def flashcard_label_fixture(attrs \\ %{}) do
      {:ok, flashcard_label} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Classifiers.create_flashcard_label()

      flashcard_label
    end

    test "list_flashcardlabels/0 returns all flashcardlabels" do
      flashcard_label = flashcard_label_fixture()
      assert Classifiers.list_flashcardlabels() == [flashcard_label]
    end

    test "get_flashcard_label!/1 returns the flashcard_label with given id" do
      flashcard_label = flashcard_label_fixture()
      assert Classifiers.get_flashcard_label!(flashcard_label.id) == flashcard_label
    end

    test "create_flashcard_label/1 with valid data creates a flashcard_label" do
      assert {:ok, %FlashcardLabel{} = flashcard_label} = Classifiers.create_flashcard_label(@valid_attrs)
      assert flashcard_label.label == "some label"
    end

    test "create_flashcard_label/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Classifiers.create_flashcard_label(@invalid_attrs)
    end

    test "update_flashcard_label/2 with valid data updates the flashcard_label" do
      flashcard_label = flashcard_label_fixture()
      assert {:ok, %FlashcardLabel{} = flashcard_label} = Classifiers.update_flashcard_label(flashcard_label, @update_attrs)
      assert flashcard_label.label == "some updated label"
    end

    test "update_flashcard_label/2 with invalid data returns error changeset" do
      flashcard_label = flashcard_label_fixture()
      assert {:error, %Ecto.Changeset{}} = Classifiers.update_flashcard_label(flashcard_label, @invalid_attrs)
      assert flashcard_label == Classifiers.get_flashcard_label!(flashcard_label.id)
    end

    test "delete_flashcard_label/1 deletes the flashcard_label" do
      flashcard_label = flashcard_label_fixture()
      assert {:ok, %FlashcardLabel{}} = Classifiers.delete_flashcard_label(flashcard_label)
      assert_raise Ecto.NoResultsError, fn -> Classifiers.get_flashcard_label!(flashcard_label.id) end
    end

    test "change_flashcard_label/1 returns a flashcard_label changeset" do
      flashcard_label = flashcard_label_fixture()
      assert %Ecto.Changeset{} = Classifiers.change_flashcard_label(flashcard_label)
    end
  end
end
