defmodule HellophoenixWeb.Router do
  use HellophoenixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :reviews_checks do
    plug :ensure_authenticated_user
    plug :ensure_user_owns_review
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/admin", HellophoenixWeb.Admin, as: :admin  do
    pipe_through :browser

    resources "/reviews", ReviewController
  end

  scope "/", HellophoenixWeb do
    pipe_through :browser # Use the default browser stack

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

    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    resources "/users", UserController do
      resources "/photos", PhotoController
    end

    resources "/reviews", ReviewController
    resources "/posts", PostController, only: [:index, :show]
    resources "/comments", CommentController, except: [:delete]

  end

  #This means that all routes starting with /jobs will be sent to the BackgroundJob.Plug module.
  forward "/jobs", BackgroundJob.Plug, name: "A forwarded job"

  # Other scopes may use custom stacks.
  # scope "/api", HellophoenixWeb do
  #   pipe_through :api
  # end


  scope "/reviews2" HellophoenixWeb do
    pipe_through :reviews_checks
    resources "/", ReviewController
  #Use multiple pipelines
  #  pipe_through [:browser, :reviews_checks, :other_stuff]
  #  resources "/", HellophoenixWeb.ReviewController
  #end

end
