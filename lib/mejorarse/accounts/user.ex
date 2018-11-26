defmodule Mejorarse.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mejorarse.Accounts.Credential
  alias Mejorarse.Accounts


  schema "users" do
    field :name, :string
    field :username, :string
    has_one :credential, Credential

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> unique_constraint(:username)
  end

  @doc """
  Get a user either by username or by email. Verify their password.

  """
  def get_and_auth_user(username_or_email, password) do
    user_by_email = Accounts.get_user_by_email(username_or_email)
    user_by_username = Accounts.get_user_by_username(username_or_email)

    require IEx; IEx.pry()

    user =
    cond do
      user_by_username != nil ->
        user_by_username
      user_by_email != nil ->
        user_by_email
      true ->
        nil
    end

    case Comeonin.Argon2.check_pass(user.credential, password) do
      {:ok, _} -> user
      _else       -> nil
    end
  end
end
