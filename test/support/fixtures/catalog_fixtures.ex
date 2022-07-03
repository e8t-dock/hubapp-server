defmodule App.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `App.Catalog` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        desc: "some desc",
        image_url: "some image_url",
        name: "some name",
        sku: 42,
        unit_price: 120.5
      })
      |> App.Catalog.create_product()

    product
  end
end
