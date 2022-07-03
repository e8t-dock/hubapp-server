defmodule AppWeb.ProductView do
  use AppWeb, :view
  alias AppWeb.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{
      id: product.id,
      name: product.name,
      sku: product.sku,
      unit_price: product.unit_price,
      image_url: product.image_url,
      desc: product.desc
    }
  end
end
