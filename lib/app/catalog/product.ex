defmodule App.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :desc, :string
    field :image_url, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :sku, :unit_price, :image_url, :desc])
    |> validate_required([:name, :sku, :unit_price, :image_url, :desc])
  end
end
