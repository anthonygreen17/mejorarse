defmodule Mejorarse.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset

  alias Mejorarse.Accounts.User


  schema "credentials" do
    field :email, :string
    field :password_hash, :string
    field :pw_last_try, :utc_datetime
    field :pw_tries, :integer
    belongs_to :user, User


    # virtual lets the user submit a password along with their
    # request, but its not actually stored in the DB
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true  

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email, :password, :password_confirmation])
    |> validate_confirmation(:password)
    |> validate_password(:password)
    |> put_password_hash()
    |> validate_required([:email, :password_hash])
    |> unique_constraint(:email, message: "Email already taken")
  end

  # Password validation
  # From Comeonin docs
  def validate_password(changeset, field, options \\ []) do
    validate_change(changeset, field,
      fn _, password ->
        case valid_password?(password) do
          {:ok, _} -> []
          {:error, msg} -> [{field, options[:message] || msg}]
        end
      end
    )
  end


  ########################################
  # These functions were taken from ntuck's lecture notes on 10/16 - passwords/security
  ########################################

  # pattern match - We're ony interested in VALID changesets (ie: valid password)
  def put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do

    # as long as we name the 2nd virtual field "password_hash", this will work correctly
    # and update the "password_hash" field
    #
    # this actually sets password to nil and puts the hash in password_hash
    change(changeset, Comeonin.Argon2.add_hash(password))
  end

  # pattern match an invalid changeset
  def put_password_hash(changeset), do: changeset

  def valid_password?(password) when byte_size(password) > 7 do
    {:ok, password}
  end
  def valid_password?(_), do: {:error, "The password is too short"}

end
