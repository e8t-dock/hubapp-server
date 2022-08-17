defmodule AppWeb.Plug.GraphQL.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})

      _ ->
        conn
    end
  end

  defp build_context(conn) do
    # <<_::binary-size(3), token::binary>> = header

    prefix_size = byte_size("Bearer ")

    with [<<_::binary-size(prefix_size), token::binary>>] <-
           get_req_header(conn, "authorization"),
         {:ok, user, _claims} <- App.Guardian.resource_from_token(token) do
      {:ok, %{current_user: user}}
    end
    |> IO.inspect()
  end
end
