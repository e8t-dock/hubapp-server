defmodule AppWeb.GraphQL.Resolvers.Accounts do
  alias App.Guardian
  alias App.Account
  alias App.Account.User
  require Logger

  def create_user(parent, arg, context) do
    Logger.info("parent #{inspect(parent)}")
    Logger.info("arg #{inspect(arg)}")
    Logger.info("context #{inspect(context)}")

    case Account.register_user(arg) do
      {:ok, %User{} = user} ->
        {:ok, user}

      {:error, changeset} ->
        Logger.info(inspect_errors(changeset))
        {:error, %{message: inspect_errors(changeset)}}
    end
  end

  def signin(%{email: email, password: password}, info) do
    Logger.info("info #{inspect(info)}")

    with {:ok, %User{} = user} <- Account.get_user_by_email_and_password(email, password),
         {:ok, jwt, _full_claims} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt}}
    else
      {:error, reason} -> {:error, "Incorrect email or password [#{reason}]"}
    end
  end

  defp inspect_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
