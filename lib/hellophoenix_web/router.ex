defmodule HellophoenixWeb.Plugs.Locale do
  import Plug.Conn

  @locales ["en", "fr", "de"]

  def init(default), do: default

  def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
    assign(conn, :locale, loc)
  end

  def call(conn, default), do: assign(conn, :locale, default)

end

defmodule HellophoenixWeb.Router do
  use HellophoenixWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "text"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug HellophoenixWeb.Plugs.Locale, "fr"
    #plug OurAuth
    #plug :put_user_token
  end

  defp put_user_token(conn, _) do
    if current_user =  conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

  defp autheticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil -> 
        conn 
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      user_id -> 
        assign(conn, :current_user, Hellophoenix.Accounts.get_user!(user_id))
    end
  end

  #pipeline :reviews_checks do
  #  plug :ensure_authenticated_user
  #  plug :ensure_user_owns_review
  #end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/admin", HellophoenixWeb.Admin, as: :admin  do
    pipe_through :browser

    resources "/reviews", ReviewController
  end

  scope "/", HellophoenixWeb do
    pipe_through :browser # Use the default browser stack

    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete], singleton: true
    #singleton: true option, which defines all the RESTful routes,
    #but does not require a resource ID to be passed along in the URL

    #We can even use the forward/4 macro in a pipeline. 
    #If we wanted to ensure that the user was authenticated and an 
    #administrator in order to see the jobs page, we could use the following in our router.
    #pipe_through [:authenticate_user, :ensure_admin]
    #forward "/jobs", BackgroundJob.Plug


    #The opts that are passed to the init/1 callback of 
    #a Plug can be passed as a 3rd argument.
    #For example, maybe the background job page lets you 
    #set the name of your application to be displayed on the page. This could be passed with:
    #forward "/jobs", BackgroundJob.Plug, name: "Hello Phoenix"


    get "/", PageController, :index
    get "/test", PageController, :test
    get "/sampletemplate", PageController, :sampletemplate
    get "/redirect_test", PageController, :redirect_test, as: :redirect_test
    get "/showtext", PageController, :showText
    get "/showjson", PageController, :showJson
    get "/showhtml", PageController, :showHtml


    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    resources "/users", UserController do
      resources "/photos", PhotoController
    end

    resources "/reviews", ReviewController
    resources "/posts", PostController, only: [:index, :show]
    resources "/comments", CommentController, except: [:delete]

  end

  scope "/cms", HellophoenixWeb.CMS, as: :cms do
    pipe_through [:browser, :autheticate_user]

    resources "/pages", PageController
  end

  #This means that all routes starting with /jobs will be sent to the BackgroundJob.Plug module.
  forward "/jobs", BackgroundJob.Plug, name: "A forwarded job"

  # Other scopes may use custom stacks.
  # scope "/api", HellophoenixWeb do
  #   pipe_through :api
  # end


  #scope "/reviews2" HellophoenixWeb do
  #  pipe_through :reviews_checks
  #  resources "/", ReviewController
  #Use multiple pipelines
  #  pipe_through [:browser, :reviews_checks, :other_stuff]
  #  resources "/", HellophoenixWeb.ReviewController
  #end

end
