defmodule Swap.Action do
  use Ecto.Schema

  alias Swap.Action.{ListByRepository, ListAll}

  defdelegate list_by_repo(repo_id), to: ListByRepository, as: :call
  defdelegate list_all(), to: ListAll, as: :call

  schema "action" do
    field(:name, :string)
    field(:url, :string)
    field(:event, :string)
    belongs_to(:repository, Swap.GithubRepository)

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> Ecto.Changeset.cast(params, [:name, :url, :event, :repository_id])
    |> Ecto.Changeset.validate_required([:name, :url, :event, :repository_id])
  end
end
