defmodule Swap.Repo.Migrations.CreateGithubRepository do
  use Ecto.Migration

  def change do
    create table(:github_repository) do
      add :name, :string
      add :owner, :string
      add :last_checked_at, :naive_datetime

      timestamps()
    end
  end
end
