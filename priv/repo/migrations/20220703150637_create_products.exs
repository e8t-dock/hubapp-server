defmodule App.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :sku, :integer
      add :unit_price, :float
      add :image_url, :string
      add :desc, :string

      timestamps()
    end
  end
end
