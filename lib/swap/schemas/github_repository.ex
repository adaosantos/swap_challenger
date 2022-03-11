defmodule Swap.Schemas.GithubRepository do
  use Ecto.Schema

  schema "github_repository" do
    field :name, :string
    field :owner, :string
    field :last_checked_at, :naive_datetime
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:name, :owner, :last_checked_at])
    |> Ecto.Changeset.validate_required([:name, :owner])
  end
end
