defmodule App.CatalogTest do
  use App.DataCase

  alias App.Catalog

  describe "products" do
    alias App.Catalog.Product

    import App.CatalogFixtures

    @invalid_attrs %{desc: nil, image_url: nil, name: nil, sku: nil, unit_price: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Catalog.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Catalog.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{desc: "some desc", image_url: "some image_url", name: "some name", sku: 42, unit_price: 120.5}

      assert {:ok, %Product{} = product} = Catalog.create_product(valid_attrs)
      assert product.desc == "some desc"
      assert product.image_url == "some image_url"
      assert product.name == "some name"
      assert product.sku == 42
      assert product.unit_price == 120.5
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{desc: "some updated desc", image_url: "some updated image_url", name: "some updated name", sku: 43, unit_price: 456.7}

      assert {:ok, %Product{} = product} = Catalog.update_product(product, update_attrs)
      assert product.desc == "some updated desc"
      assert product.image_url == "some updated image_url"
      assert product.name == "some updated name"
      assert product.sku == 43
      assert product.unit_price == 456.7
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product(product, @invalid_attrs)
      assert product == Catalog.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Catalog.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Catalog.change_product(product)
    end
  end
end
