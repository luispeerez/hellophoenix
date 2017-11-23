defmodule Hellophoenix.CMS.Page do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hellophoenix.CMS.{Page, Author}


  schema "pages" do
    field :body, :string
    field :title, :string
    field :views, :integer
    belongs_to :author, :integer

    timestamps()
  end

  @doc false
  def changeset(%Page{} = page, attrs) do
    page
    |> cast(attrs, [:title, :body, :views])
    |> validate_required([:title, :body, :views])
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end
end
