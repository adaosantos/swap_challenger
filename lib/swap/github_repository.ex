defmodule Swap.GithubRepository do
  use Ecto.Schema

  alias Swap.GithubRepository.ListAll

  schema "github_repository" do
    field(:name, :string)
    field(:owner, :string)
    field(:last_checked_at, :naive_datetime)
    has_many(:actions, Swap.Action, on_delete: :delete_all)
    timestamps()
  end

  defdelegate list_all, to: ListAll, as: :call

  def changeset(params) do
    %__MODULE__{}
    |> Ecto.Changeset.cast(params, [:name, :owner, :last_checked_at])
    |> Ecto.Changeset.validate_required([:name, :owner])
    |> Ecto.Changeset.unique_constraint([:name, :owner])
  end
end
