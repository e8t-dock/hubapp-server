defmodule AppWeb.GraphQL.Schema.UserTypes do
  use Absinthe.Schema.Notation
  alias AppWeb.GraphQL.Resolvers

  # model

  @desc "Single User"
  object :user do
    field :email, :string
    field :id, :id
  end

  @desc "session value"
  object :session do
    field :token, :string
    field :user, :user
  end

  # query

  object :create_user_mutation do
    @desc """
    create user
    """
    @desc "Create a uer"
    field :create_user, :user do
      arg(:username, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      arg(:password_confirmation, non_null(:string))

      resolve(&Resolvers.Accounts.create_user/3)
    end
  end

  object :signin_mutation do
    @desc """
    signin with the params
    """
    field :create_session, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.Accounts.signin/2)
    end
  end
end
