defmodule AppWeb.GraphQL.Resolvers.Products do
  alias App.Catalog
  alias App.Catalog.Product
  require Logger

  def list_products(args, context) do
    Logger.info([args, context])
    {:ok, Catalog.list_products()}
  end

  def get_product(%{id: id}, _context) do
    case Catalog.get_product(id) do
      nil -> {:error, "Product not found"}
      %Product{} = product -> {:ok, product}
    end
  end

  def create_product(args, %{context: %{current_user: user}}) do
    Logger.info(user)

    case Catalog.create_product(args) do
      {:ok, %Product{} = product} -> {:ok, product}
      {:error, changeset} -> {:error, inspect(changeset.errors)}
    end
  end

  def create_product(_args, _context), do: {:error, "Not Authorized"}

  def update_product(%{id: id} = params, %{context: %{current_user: _user}}) do
    case Catalog.get_product(id) do
      nil ->
        {:error, "Product not found"}

      %Product{} = product ->
        case Catalog.update_product(product, params) do
          {:ok, %Product{} = product} -> {:ok, product}
          {:error, changeset} -> {:error, inspect(changeset.errors)}
        end
    end
  end

  def update_product(_args, _context), do: {:error, "Not Authorized"}

  def delete_product(%{id: id}, %{context: %{current_user: _user}}) do
    case Catalog.get_product(id) do
      nil -> {:error, "Product not found"}
      %Product{} = product -> Catalog.delete_product(product)
    end
  end

  def delete_product(_args, _context), do: {:error, "Not Authorized"}
end
