defmodule Hellophoenix.Repo.Migrations.CreateCredentials do
  use Ecto.Migration

  def change do
    create table(:credentials) do
      add :email, :string
      #null: false  to disallow creating credentials without an existing user.
      #By using a database constraint, we enforce data integrity at the database level,
      #rather than relying on ad-hoc and error-prone application logic.
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:credentials, [:email])
    create index(:credentials, [:user_id])
  end
end
