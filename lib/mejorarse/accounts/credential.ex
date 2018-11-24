defmodule Mejorarse.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset


  schema "credentials" do
    field :email, :string
    field :password_hash, :string
    field :pw_last_try, :string
    field :pw_tries, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email, :password_hash, :pw_tries, :pw_last_try])
    |> validate_required([:email, :password_hash, :pw_tries, :pw_last_try])
    |> unique_constraint(:email)
  end
end
