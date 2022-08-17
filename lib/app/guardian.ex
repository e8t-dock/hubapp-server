defmodule App.Guardian do
  use Guardian, otp_app: :app

  alias App.Account

  # def subject_for_token(resource, _claims) do
  #   sub = to_string(resource.id)
  #   {:ok, sub}
  # end

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  # def resource_from_claims(claims) do
  #   id = claims["sub"]
  #   resource = Account.get_user!(id)
  #   {:ok, resource}
  # end

  def resource_from_claims(%{"sub" => id}) do
    resource = Account.get_user!(id)
    {:ok, resource}
  end

  def resource_from_claims(_) do
    {:error, :reason_for_error}
  end
end
