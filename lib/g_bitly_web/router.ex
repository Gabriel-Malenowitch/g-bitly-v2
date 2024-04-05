defmodule GBitlyWeb.Router do
  use GBitlyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GBitlyWeb do
    pipe_through :api

    get "/", URLsController, :list_all
    get "/:from/:to", URLsController, :create
    get "/:to", URLsController, :my_redirect
  end
end
