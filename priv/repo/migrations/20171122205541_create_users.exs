defmodule Hellophoenix.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string
      add :email, :string
      add :bio, :string
      add :number_of_pets, :integer

      timestamps()
    end

  end
end
