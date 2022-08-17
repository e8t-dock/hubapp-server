defmodule AppWeb.GraphQL.Schema.ProductTypes do
  use Absinthe.Schema.Notation
  alias AppWeb.GraphQL.Resolvers

  @desc "Single product"
  object :product do
    field :id, :id
    field :name, :string
    field :sku, :integer
    field :unit_price, :float
    field :image_url, :string
    field :desc, :string
  end

  object :get_products do
    @desc """
    Get a list of products
    """
    # field 第一个参数对应 query root schema 值
    field :products, list_of(:product) do
      resolve(&Resolvers.Products.list_products/2)
    end
  end

  object :get_product do
    @desc """
    Get a product
    """
    field :product, :product do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Products.get_product/2)
    end
  end

  object :create_product do
    @desc """
    Create a product
    """
    field :create_product, :product do
      arg(:name, non_null(:string))
      arg(:sku, non_null(:integer))
      arg(:unit_price, non_null(:float))
      arg(:image_url, non_null(:string))
      arg(:desc, non_null(:string))
      resolve(&Resolvers.Products.create_product/2)
    end
  end

  object :update_product do
    @desc """
    Update a product
    """
    field :update_product, :product do
      arg(:id, non_null(:id))
      arg(:name, :string)
      arg(:unit_price, :float)
      arg(:image_url, :string)
      arg(:desc, :string)
      resolve(&Resolvers.Products.update_product/2)
    end
  end

  object :delete_product do
    @desc """
    Delete a product
    """
    field :delete_product, :product do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Products.delete_product/2)
    end
  end
end
