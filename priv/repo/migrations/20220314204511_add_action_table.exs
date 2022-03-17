defmodule Swap.Repo.Migrations.AddActionTable do
  use Ecto.Migration

  def change do
    create table(:action) do
      add :name, :string
      add :url, :string
      add :event, :string
      add :repository_id, references(:github_repository)

      timestamps()
    end
  end
end
