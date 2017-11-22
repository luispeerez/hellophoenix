defmodule HellophoenixWeb.PageController do
  use HellophoenixWeb, :controller

  #plug :assign_welcome_message, "Welcome this is a default msg"
  plug :assign_welcome_message, "Hi!" when action in [:index, :showHtml]

  defp assign_welcome_message(conn, msg) do
    assign(conn, :message, msg)
  end

  def index(conn, _params) do
    conn 
    |> put_flash(:info, "Welcome to phoenix, from flash info!")
    |> put_flash(:error, "Lets pretend we have an error")
    |> assign(:message, "Welcome back")
    |> assign(:name, "Foobaro")
    #|> put_layout(false)
    #|> render("index.html")
  	|> render(:index)
    #pipes passes the return as the first param of the next function in pipe
    #render conn, "index.html"
  end

  def sampletemplate(conn, _) do
    render(conn, "sampletemplate.html")
  end

  def test(conn, _params) do
  	conn 
    |> put_layout("admin.html")
    |> render("index.html")
    #|> send_resp(201, "")
    #render conn, "index.html"
  end

  def redirect_test(conn, _params) do
    text(conn, "Redirect!!!")
  end

  def showText(conn, %{"id" => id}) do
  	text(conn, "Showing item with id #{id}")
  end

  def showText(conn, _) do
    redirect(conn, to: "/redirect_test")
  end

  def showJson(conn, %{"id" => id}) do
  	json(conn, %{id: id})
  end

  def showHtml(conn, %{"id" => id}) do
  	html conn, """
			<html>
				<head>
					<title>HTML VIEW</title>
				</head>
				<body>
          <p>#{conn.assigns.message}</p>
					<p>You sent: #{id}</p>
				</body>
			</html>
  	"""
  end

end
